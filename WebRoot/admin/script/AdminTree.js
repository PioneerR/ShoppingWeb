var isIE = true;
var imgUp = "images/arrowUp.gif" ;
var imgDn = "images/arrowDn.gif" ;
function expandIt( head, fExpandOnly )
{
//alert(!fExpandOnly);
	var bulletImg ;
	var allCol = "document." + ( isIE ? "all." : "" ) + head ;
	var parentDiv = eval( allCol + "Parent" );//也可以不用eval方法
	var childDiv  = eval( allCol + "Child" );
	if ( isIE )
	{
		if ( parentDiv )
		//变量如果不为0，null，undefined，false，都会被处理为true。
		//只要变量有非0的值或是某个对象，数组，字符串，都会认为true
			bulletImg = parentDiv.children( 0 ).children( 'imEx' );
		//等价于bulletImg=document.getElementByName('name名');由于name值相同，所以该方法获得的是一个集合
		//而getElementById()只能获取一个元素，因为id具有唯一性
		//children(0)取得元素集合，children('元素id')取得元素集合中的具体元素
		//children方法可能只适用于IE，且document.all已经过时，现在用的是document.getElementByName等
		if ( childDiv )
		{
			if ( childDiv.style.display == "block" && (!fExpandOnly) )
			{
				childDiv.style.display	= "none" ;
				if ( bulletImg )
					bulletImg.src = imgUp ;//只是用于更改展开或不展开时，parent的图标，可以不写
			}
			else
			{
				childDiv.style.display	= "block" ;
				if ( bulletImg )
					bulletImg.src = imgDn ;//只是用于更改展开或不展开时，parent的图标，可以不写
			}
		}
	}
	else
	{
		if ( parentDiv )
			bulletImg = parentDiv.document.images['imEx'];
		if ( childDiv )
		{
			if ( childDiv.visibility == "hidden" )
			{
				childDiv.visibility = "visible" ;
				if ( bulletImg )
					bulletImg.src = imgDn ;
			}
			else if ( ! fExpandOnly ) 
			{
				childDiv.visibility = "hidden";
				if ( bulletImg )
					bulletImg.src = imgUp ;
			}
		}
	}
	return false ;	// cancels event
}

function doClick ( )
{
	el = event.srcElement;
	while ( el && el.tagName != "A" ) 
	{
		el = el.parentElement ;
	}
	if ( ! el ) return ;
	if ( el.target != "main" ) return ;
	hiliteSel( el );	
}
var prevSel = null ;
function hiliteSel ( selLink )
{
	var selColor = "red" ;
	if ( prevSel )
	{
		prevSel.style.color = prevSel.prevColor ;
	}
	prevSel = selLink ;
	prevSel.prevColor = selLink.style.color ;
	selLink.style.color = selColor ;
}

function init() {
  document.onclick = doClick ;
  expandIt("head2");
  //hiliteSel(ttt);
//  parent.frames("Main").location.href = "/gtc/programMgr.html";
}

if ( screen.colorDepth > 8 )
{
//	document.write( "<STYLE>BODY{background-image:url(/images/ai/tile_nav.jpg);}</STYLE>" );
}
var licenseID ='01-0006-0038-69648' ;
var pendingChanges =false ;


