#include <R.h>
#include <Rversion.h>
#include <Rinternals.h>
#include <R_ext/GraphicsEngine.h>
#include <R_ext/GraphicsDevice.h>
#include <R_ext/Rdynload.h>

#if R_VERSION >= R_Version(2,8,0)
#ifndef NewDevDesc
#define NewDevDesc DevDesc
#endif
#endif

#include <ming.h>

#define REDC(C) (((int)(C))&0xff)
#define GREENC(C) ((((int)(C))&0xff00)>>8)
#define BLUEC(C) ((((int)(C))&0xff0000)>>16)
#define ALPHAC(C) ((((int)(C))&0xff000000)>>24)

#define MINGSWF_SET_COLOR(m,c) { m->red=(byte)REDC(c); m->green=(byte)GREENC(c); m->blue=(byte)BLUEC(c); m->alpha=(byte)ALPHAC(c); }
#define MINGSWF_SET_LINE(m,s,c) if (m->version<8) {SWFShape_setLine(s,c->lwd,m->red,m->green,m->blue,m->alpha);} else { MingSWFSetLineType(m,c); SWFShape_setLine2(s,c->lwd,m->red,m->green,m->blue,m->alpha,m->lty,m->miterLimit); }

typedef struct _MingSWFDesc {
	/* device specific stuff */
	byte red;
	byte green;
	byte blue;
	byte alpha;
	short lwd;
	int lty;
	float miterLimit;
	int version;
	SWFMovie movie;
	char *file;
	pGEDevDesc RGE;
} MingSWFDesc;

void MingSWF_SetLabelActions( SWFDisplayItem display_item){

		// Add onRollOver, onRollOut
		SWFDisplayItem_addAction(display_item,newSWFAction("_root.showPopUp(this);"),SWFACTION_ROLLOVER);

		SWFDisplayItem_addAction(display_item,newSWFAction("_root.hidePopUp(this);"),SWFACTION_ROLLOUT|SWFACTION_RELEASEOUTSIDE);
}

void Fixed_SWFShape_drawCircle(SWFShape shape, double r, double startAngle, double endAngle)
{
	int i;
	double controlx, controly, anchorx, anchory, x, y;

	/* first determine number of segments, 8 at most */
	int nSegs = (int)(1 + floor(15*(endAngle-startAngle)/360));

	/* subangle is half the angle of each segment */
	double subangle = M_PI*(endAngle-startAngle)/nSegs/360;

	double angle = M_PI*startAngle/180;

	x = r*sin(angle);
	y = -(r*cos(angle));

	SWFShape_movePen(shape, x, y);

	for ( i=0; i<nSegs; ++i )
	{
		angle += subangle;
		controlx = (r*sin(angle)/cos(subangle));
		controly = (-r*cos(angle)/cos(subangle));
		angle += subangle;
		anchorx = (r*sin(angle));
		anchory = (-r*cos(angle));

		SWFShape_drawCurve(shape, controlx-x, controly-y,
		                   anchorx-controlx, anchory-controly);

		x = anchorx;
		y = anchory;
	}
}

static void MingSWFSetLineType( MingSWFDesc *MGD, pGEcontext gc)
{
	/* Line end: par lend  */
	MGD->lty = 0;
	MGD->miterLimit = 2.0;
	switch(gc->lend){
		case GE_ROUND_CAP: MGD->lty =  SWF_LINESTYLE_CAP_ROUND |SWF_LINESTYLE_FLAG_ENDCAP_ROUND; break;
		case GE_BUTT_CAP: MGD->lty =   SWF_LINESTYLE_CAP_NONE  |SWF_LINESTYLE_FLAG_ENDCAP_NONE; break;
		case GE_SQUARE_CAP: MGD->lty = SWF_LINESTYLE_CAP_SQUARE|SWF_LINESTYLE_FLAG_ENDCAP_SQUARE; break;
	}

	/* Line join: par ljoin */
	switch(gc->ljoin){
		case GE_ROUND_JOIN: MGD->lty |= SWF_LINESTYLE_JOIN_ROUND; break;
		case GE_MITRE_JOIN: MGD->lty |= SWF_LINESTYLE_JOIN_MITER; break;
		case GE_BEVEL_JOIN: MGD->lty |= SWF_LINESTYLE_JOIN_BEVEL; break;
	} 
}

static void MingSWFActivate(const pDevDesc RGD)
{ 
#ifdef MINGSWFDEBUG
	Rprintf("Activate(RGD=0x%x)\n",RGD);
#endif
}

static void MingSWFCircle(double x, double y, double r, const pGEcontext gc, pDevDesc RGD)
{
	MingSWFDesc *MGD = (MingSWFDesc *)RGD->deviceSpecific;
	SWFShape circle = newSWFShape();
	SWFMovieClip mcCircle;
	SWFDisplayItem display_item;
	char strBuffer[1024];

	mcCircle = newSWFMovieClip();
	sprintf(strBuffer,"var Label = \"x=<b>%.2f</b>, y=%.2f\\nradius is %.2f\";",x,y,r);
	SWFMovieClip_add(mcCircle, (SWFBlock) newSWFAction(strBuffer));


	if (gc->fill){
		SWFShape fcircle; 
		SWFFillStyle fill;
		fcircle = newSWFShape();
		SWFShape_movePenTo(fcircle, x, y);
		MINGSWF_SET_COLOR(MGD,gc->fill);
		fill = newSWFSolidFillStyle(MGD->red,MGD->green,MGD->blue,MGD->alpha);
        SWFShape_setRightFillStyle(fcircle, fill);
		Fixed_SWFShape_drawCircle(fcircle, r<2.0?2.0:r, 0 , 360);
		/*SWFMovie_add(MGD->movie, (SWFBlock) fcircle);*/
		SWFMovieClip_add(mcCircle, (SWFBlock) fcircle);
	}

	SWFShape_movePenTo(circle, x, y);
	MINGSWF_SET_COLOR(MGD,gc->col);
	MINGSWF_SET_LINE(MGD,circle,gc);
	/* curve drawing is flawed with setLine2() for some reason */
	/*SWFShape_setLine(circle,gc->lwd,MGD->red,MGD->green,MGD->blue,MGD->alpha);*/

	/* SWFShape_drawCircle(circle, (int)(r<2.0?2.0:r)); */
	Fixed_SWFShape_drawCircle(circle, r<2.0?2.0:r, 0 , 360);
	/*SWFDisplayItem_moveTo(SWFMovie_add(MGD->movie, (SWFBlock) circle) , x, y);*/
	/* SWFMovie_add(MGD->movie, (SWFBlock) circle);*/
	/* destroySWFShape(circle); */
	if (gc->fill){
		/*destroySWFFillStyle(fill);*/
	}

	SWFMovieClip_add(mcCircle, (SWFBlock) circle);
	SWFMovieClip_nextFrame(mcCircle);

	/* Add Label Actions */
	MingSWF_SetLabelActions(SWFMovie_add(MGD->movie, (SWFBlock) mcCircle));

#ifdef MINGSWFDEBUG
	Rprintf("Circle(x=%f,y=%f,r=%f,gc=0x%x,RGD=0x%x)\n",x,y,r,gc,RGD);
	Rprintf("\tuser coords: x=%f,y=%f\n",fromDeviceX(x,GE_NDC,MGD->RGE),fromDeviceY(y,GE_NDC,MGD->RGE));
#endif
}

static void MingSWFClip(double x0, double x1, double y0, double y1, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("Clip(x0=%f,y0=%f,x1=%f,y1=%f,RGD=0x%x)\n",x0,y0,x1,y1,RGD);
#endif
}
static void MingSWFClose(pDevDesc RGD)
{
	MingSWFDesc *MGD = (MingSWFDesc *)RGD->deviceSpecific;

	/* Save plot */
	Ming_setSWFCompression(9);
	SWFMovie_save(MGD->movie, MGD->file);
	destroySWFMovie(MGD->movie);

	free(MGD);
	RGD->deviceSpecific = NULL;
#ifdef MINGSWFDEBUG
	Rprintf("Close(RGD=0x%x)\n",RGD);
#endif
}
static void MingSWFDeactivate(pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("Deactivate(RGD=0x%x)\n",RGD);
#endif
}
static Rboolean MingSWFLocator(double *x, double *y, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("Locator(x=%f,y=%f,RGD=0x%x)\n",x,y,RGD);
#endif
}
static void MingSWFLine(double x1, double y1, double x2, double y2, const pGEcontext gc, pDevDesc RGD)
{
	MingSWFDesc *MGD = (MingSWFDesc *)RGD->deviceSpecific;
	SWFShape line = newSWFShape();

	MINGSWF_SET_COLOR(MGD,gc->col);
	MINGSWF_SET_LINE(MGD,line,gc);

	SWFShape_movePenTo(line, x1, y1);
	SWFShape_drawLineTo(line, x2, y2);
	SWFMovie_add(MGD->movie, (SWFBlock) line);

#ifdef MINGSWFDEBUG
	Rprintf("Line(x0=%f,y0=%f,x1=%f,y1=%f,gc=0x%x,RGD=0x%x)\n",x1,y1,x2,y2,gc,RGD);
#endif
}
static void MingSWFMetricInfo(int c, const pGEcontext gc, double* ascent, double* descent, double* width, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("MetricInfo(c=%d,gc=0x%x,ascent=%f,descent=%f,width=%f,RGD=0x%x)\n",c,gc,ascent,descent,width,RGD);
#endif
}
static void MingSWFMode(int mode, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("Mode(mode=%d,RGD=0x%x)\n",mode,RGD);
#endif
}
static void MingSWFNewPage(const pGEcontext gc, pDevDesc RGD)
{
	MingSWFDesc *MGD = (MingSWFDesc *)RGD->deviceSpecific;
	MINGSWF_SET_COLOR(MGD,gc->fill);
	SWFMovie_setBackground(MGD->movie, MGD->red, MGD->green, MGD->blue);
#ifdef MINGSWFDEBUG
	Rprintf("NewPage(gc=0x%x,RGD=0x%x)\n",gc,RGD);
#endif
}
static void MingSWFPolygon(int n, double *x, double *y, const pGEcontext gc, pDevDesc RGD)
{
	int i;
	MingSWFDesc *MGD = (MingSWFDesc *)RGD->deviceSpecific;
	SWFShape line = newSWFShape();


	if (gc->fill){
		SWFShape fline;
        SWFFillStyle fill;
	   	fline = newSWFShape();
		MINGSWF_SET_COLOR(MGD,gc->fill);
		fill = newSWFSolidFillStyle(MGD->red,MGD->green,MGD->blue,MGD->alpha);
        SWFShape_setRightFillStyle(fline, fill);
		SWFShape_movePenTo(fline,x[0],y[0]);
		i = 1;
		while (i<n) { 
			SWFShape_drawLineTo(fline, x[i], y[i]); 
			i++; 
		}
		/* For some reason fills bleed. So ensure they don't  */
		if (((int)x[0] != (int)x[n-1]) || ((int)y[0]!=(int)y[n-1]))
			SWFShape_drawLineTo(fline, x[0], y[0]); 
		SWFMovie_add(MGD->movie, (SWFBlock) fline);
	}

	MINGSWF_SET_COLOR(MGD,gc->col);
	MINGSWF_SET_LINE(MGD,line,gc);

	SWFShape_movePenTo(line,x[0],y[0]);
	i = 1;
	while (i<n) { 
		SWFShape_drawLineTo(line, x[i], y[i]); 
		i++; 
	}

	/*SWFDisplayItem_moveTo(SWFMovie_add(MGD->movie, (SWFBlock) line),0,0);*/
	SWFMovie_add(MGD->movie, (SWFBlock) line);
	/*destroySWFShape(line);*/
#ifdef MINGSWFDEBUG
	{ int i=0;
	Rprintf("Polygon(n=%d,x=0x%x,y=0x%x,gc=0x%x,RGD=0x%x)\n\tpoints: ",n,x,y,gc,RGD);
	while(i<n){ Rprintf("(%.2f,%.2f) ",x[i],y[i]); i++;} Rprintf("\n");
	}
#endif
}
static void MingSWFPolyline(int n, double *x, double *y, const pGEcontext gc, pDevDesc RGD)
{
	int i = 1;
	MingSWFDesc *MGD = (MingSWFDesc *)RGD->deviceSpecific;
	SWFShape line = newSWFShape();

	MINGSWF_SET_COLOR(MGD,gc->col);
	MINGSWF_SET_LINE(MGD,line,gc);

	SWFShape_movePenTo(line,x[0],y[0]);
	while (i<n) { 
		SWFShape_drawLineTo(line, x[i], y[i]); 
		i++; 
	}

	/*SWFDisplayItem_moveTo(SWFMovie_add(MGD->movie, (SWFBlock) line),0,0);*/
	SWFMovie_add(MGD->movie, (SWFBlock) line);
	/*destroySWFShape(line);*/
#ifdef MINGSWFDEBUG
	{ int i=0;
	Rprintf("Polyline(n=%d,x=0x%x,y=0x%x,gc=0x%x,RGD=0x%x)\n\tpoints: ",n,x,y,gc,RGD);
	while(i<n){ Rprintf("(%.2f,%.2f) ",x[i],y[i]); i++;} Rprintf("\n");
	}
#endif
}
static void MingSWFRect(double x0, double y0, double x1, double y1, const pGEcontext gc, pDevDesc RGD)
{
	double xpos[5], ypos[5];

	/* ensure that upper left corner is (x0,y0), lower right is (x1,y1) */
	if (x1<x0) { double h=x1; x1=x0; x0=h; }
	if (y1<y0) { double h=y1; y1=y0; y0=h; }

	/* draw to the right, then down, left, and then up. */
	xpos[0] = x0; ypos[0] = y0;
	xpos[1] = x0; ypos[1] = y1;
	xpos[2] = x1; ypos[2] = y1;
	xpos[3] = x1; ypos[3] = y0;

	xpos[4] = x0; ypos[4] = y0;

	MingSWFPolygon(5,xpos,ypos,gc,RGD);

#ifdef MINGSWFDEBUG
	Rprintf("Rect(x0=%f,y0=%f,x1=%f,y1=%f,gc=0x%x,RGD=0x%x)\n",x0,y0,x1,y1,gc,RGD);
#endif
}
static void MingSWFSize(double *left, double *right, double *bottom, double *top, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("Size(left=%f,right=%f,bottom=%f,top=%f,RGD=0x%x)\n",*left,*right,*bottom,*top,RGD);
#endif
}
static double MingSWFStrWidth(const char *str, const pGEcontext gc, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("StrWidth(str=%s,gc=0x%x,RGD=0x%x)\n",str,gc,RGD);
#endif
}
static void MingSWFText(double x, double y, const char *str, double rot, double hadj, const pGEcontext gc, pDevDesc RGD)
{
#ifdef MINGSWFDEBUG
	Rprintf("Text(x=%f,y=%f,str=%s,rot=%f,hadj=%f,gc=0x%x,RGD=0x%x)\n",x,y,str,rot,hadj,gc,RGD);
#endif
}


SEXP MingSWFNew(SEXP file, SEXP height, SEXP width, SEXP scale, SEXP version, SEXP bg, SEXP fonts, SEXP initAS, SEXP labelMethod){
	int bgcolor = RGBpar(bg,0);

	/* R Graphics Device: in GraphicsDevice.h */
	pDevDesc RGD;

	/* R Graphics Engine: in GraphicsEngine.h */
	pGEDevDesc RGE;

	/* Ming Graphics Device */
	MingSWFDesc *MGD;

	if (!(RGD = (pDevDesc)calloc(1, sizeof(NewDevDesc))))
		return R_NilValue;

    if (!(MGD = (MingSWFDesc *)calloc(1, sizeof(MingSWFDesc)))){
		free(RGD);
	    error("unable to start device mingswf");
		return R_NilValue;
	}
	MGD->version = asInteger(version);
	Ming_setScale(asInteger(scale));/* default for library is 20 */
	MGD->movie = newSWFMovieWithVersion(MGD->version);
	MGD->file=(char *)CHAR(STRING_ELT(file,0));

	/* Initialize SWF file */
	SWFMovie_setDimension(MGD->movie,asReal(width),asReal(height));
	SWFMovie_setBackground(MGD->movie, REDC(bgcolor), GREENC(bgcolor), BLUEC(bgcolor));
	SWFMovie_setRate(MGD->movie, 1.0);
	SWFMovie_setNumberOfFrames(MGD->movie, 1);
	SWFMovie_add(MGD->movie,newSWFInitAction(newSWFAction(
	"_root.createEmptyMovieClip('popup',65534);"
	"_root.popup._visible = false;"
	"_root.popup.createTextField('Label',65535,0,0,0,0);"
	"_root.popup.Label.multiline = true;"
	"_root.popup.Label.html = true;"
	"_root.movePopUp = function (){"
	"	if (_root._xmouse <= _root.popup.Label._width+20){"
	"		_root.popup._x = _root._xmouse+20;"
	"	} else {"
	"		_root.popup._x = _root._xmouse-_root.popup.Label._width-10;"
	"	}"
	"	if (_root._ymouse <= _root.popup.Label._height+20){"
	"		_root.popup._y = _root._ymouse+15;"
	"	} else {"
	"		_root.popup._y = _root._ymouse-_root.popup.Label._height-10;"
	"	}"
	"	updateAfterEvent();"
	"};"
	"_root.showPopUp = function(obj){"
	"	_root.popup.Label.htmlText = obj.Label;"
	"   obj.oldAlpha = obj._alpha;"
	"   obj._alpha = 50;"
	"	_root.popup.Label.autoSize = true;"
	"	_root.popup.lineStyle(20,0xc2c2c2);"
	"	_root.popup.beginFill(0xc2c2c2);"
	"	_root.popup.moveTo(0,0);"
	"	_root.popup.lineTo(_root.popup.Label._width-5,0);"
	"	_root.popup.lineTo(_root.popup.Label._width-5,_root.popup.Label._height-5);"
	"	_root.popup.lineTo(0,_root.popup.Label._height-5);"
	"	_root.popup.lineTo(0,0);"
	"	_root.popup._visible = true;"
	"	obj.onMouseMove = _root.movePopUp;"
	"	_root.movePopUp();"
	"};"
	"_root.hidePopUp = function(obj){"
	"   obj._alpha = obj.oldAlpha;"
	"	delete obj.onMouseMove;"
	"	_root.popup.clear();"
	"	_root.popup._visible = false;"
	"};"
	)));

    RGD->deviceSpecific = (void *) MGD;

	/* Callbacks */
    RGD->close = MingSWFClose;
    RGD->activate = MingSWFActivate;
    RGD->deactivate = MingSWFDeactivate;
    RGD->size = MingSWFSize;
    RGD->newPage = MingSWFNewPage;
    RGD->clip = MingSWFClip;
    RGD->strWidth = MingSWFStrWidth;
    RGD->text = MingSWFText;
    RGD->rect = MingSWFRect;
    RGD->circle = MingSWFCircle;
    RGD->line = MingSWFLine;
    RGD->polyline = MingSWFPolyline;
    RGD->polygon = MingSWFPolygon;
    RGD->locator = MingSWFLocator;
    RGD->mode = MingSWFMode;
    RGD->metricInfo = MingSWFMetricInfo;
	RGD->hasTextUTF8 = TRUE;
    RGD->strWidthUTF8 = MingSWFStrWidth;
    RGD->textUTF8 = MingSWFText;
	RGD->wantSymbolUTF8 = TRUE;

	/* Initialise RGD */
	RGD->left = RGD->clipLeft = 0;
	RGD->top = RGD->clipTop = 0;
	RGD->right = RGD->clipRight = asReal(width);
	RGD->bottom = RGD->clipBottom = asReal(height);
	RGD->xCharOffset = 0.4900;
	RGD->yCharOffset = 0.3333;
	RGD->yLineBias = 0.1;
	RGD->ipr[0] = 1.0/72.0;
	RGD->ipr[1] = 1.0/72.0;
	RGD->cra[0] = 0.9 * 12;
	RGD->cra[1] = 1.2 * 12;
	RGD->gamma = 1.0;
	RGD->canClip = FALSE;
    RGD->canChangeGamma = FALSE;
    RGD->canHAdj = 2;
	RGD->startps = 12.0;
	RGD->startcol = R_RGB(0,0,0);
	RGD->startfill = 0xffffffff;
	RGD->startlty = LTY_SOLID;
	RGD->startfont = 1;
	RGD->startgamma = RGD->gamma;
    RGD->displayListOn = TRUE;


	/* Add to the device list */
	RGE = GEcreateDevDesc(RGD);
	MGD->RGE = RGE;
	GEaddDevice(RGE);
	GEinitDisplayList(RGE);

	return ScalarInteger(1 + GEdeviceNumber(RGE));
}

static	R_CallMethodDef CallEntries[] = {
	{"MingSWFNew",(DL_FUNC) &MingSWFNew,7},
	{NULL,NULL,0},
};

void R_init_MingSWF(DllInfo *dll)
{
	R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
	Ming_init();
}
