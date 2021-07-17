'use strict';



	// "######################################################################################################################",
	// "##              #              #                #             #              ##  Fuel:    999,999,999,999,999,999  ##",// 25 chars long 
	// "##  //////////  #  //////////  #  ////////////  #  /////////  #  //////////  ##  Ammo:    999,999,999,999,999,999  ##",// excluding spaces
	// "##  // Base //  #  // Shop //  #  //  Farm  //  #  // Map //  #  // Menu //  ##  Steel:   999,999,999,999,999,999  ##",// on either side
	// "##  //////////  #  //////////  #  ////////////  #  /////////  #  //////////  ##  Bauxite: 999,999,999,999,999,999  ##",
	// "##              #              #                #             #              ##                                    ##",
	// "#####################################################################################################################",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                   art here                                                      ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "##                                                                                                                 ##",
	// "#####################################################################################################################"
var asciiNavbar = [
	"#####################################################################################################################",
	"##              #              #                #             #              ##  Fuel:    <span id='fuel_count'>                       </span>  ##",// 25 chars long 
	"##              #              #                #             #              ##  Ammo:    <span id='ammo_count'>                       </span>  ##",// excluding spaces
	"##              #              #                #             #              ##  Steel:   <span id='steel_count'>                       </span>  ##",// on either side
	"##              #              #                #             #              ##  Bauxite: <span id='bauxite_count'>                       </span>  ##",
	"##              #              #                #             #              ##                                    ##",
	"#####################################################################################################################",
];

var asciiBase = [
	"#####################################################################################################################",
	"##                                                                                                                 ##",
	"##                                                                                                                 ##",
	"##                                                                                                                 ##",
	"##                                                  ╦ ╦┌─┐┬ ┬  ╔╦╗┌─┐┬┌┬┐┌─┐┬┌─┬ ┬┬                                ##",
	"##                                                  ╠═╣├┤ └┬┘   ║ ├┤ │ │ │ │├┴┐│ ││                                ##",
	"##                                                  ╩ ╩└─┘ ┴    ╩ └─┘┴ ┴ └─┘┴ ┴└─┘o                                ##",
	"##                                                  ╦ ╦┌─┐┬─┐┌─┐  ┬ ┬┌┐┌┌┬┐┌─┐┬─┐                                  ##",
	"##                                                  ║║║├┤ ├┬┘├┤   │ ││││ ││├┤ ├┬┘                                  ##",
	"##                                                  ╚╩╝└─┘┴└─└─┘  └─┘┘└┘─┴┘└─┘┴└─                                  ##",
	"##                   .--.___                        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┬┌─┐┌┐┌┬                            ##",
	"##                 .`--.___ `---.__                 │  │ ││││└─┐ │ ├┬┘│ ││   │ ││ │││││                            ##",
	"##                |-.___   `---._.|                 └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ ┴└─┘┘└┘o                            ##",
	"##                |     `---.__.` |                 ╔═╗┬ ┬┌─┐┌─┐┬┌─  ┌┐ ┌─┐┌─┐┬┌─  ┬  ┌─┐┌┬┐┌─┐┬─┐┬                ##",
	"##              .`|           |   |.___             ║  ├─┤├┤ │  ├┴┐  ├┴┐├─┤│  ├┴┐  │  ├─┤ │ ├┤ ├┬┘│                ##",
	"##            .`  `--.___     |  .` .`|             ╚═╝┴ ┴└─┘└─┘┴ ┴  └─┘┴ ┴└─┘┴ ┴  ┴─┘┴ ┴ ┴ └─┘┴└─o                ##",
	"##            |``---.___ `---.|.`-.`  |                                                                            ##",
	"##            |         `---.___.`    |                                                                            ##",
	"##          .`|                |      |                                                                            ##",
	"##        .`-.|                |     .``---.___                                                                    ##",
	"##      .`    |                |   .`         .|                                                                   ##",
	"##    .`       `---.___        | .`         .` |                                                                   ##",
	"##  .`.__              `---.___|` `--.___ .`   |                                                                   ##",
	"##  |    `---.___                       .`     |                                                                   ##",
	"##  |            `---.___             .`       |                                                                   ##",
	"##  |                    `---.___   .`         |                                                                   ##",
	"##  |                            `.`         .`                                                                    ##",
	"##  |                             |        .`                                                                      ##",
	"##   --.__                        |      .`                                                                        ##",
	"##        `---.___                |    .`                                                                          ##",
	"##                `---.___        |  .`                                                                            ##",
	"##                        `---.___|.`                                                                              ##",
	"##                                                                                                                 ##",
	"##                                                                                                                 ##",
	"#####################################################################################################################"];


var asciiShop = [
	"#####################################################################################################################",
	"##                      ...  !`:     ______________________________________    ________________________________    ##",
	"##                  ....++++ ....   / What would you like today, Admiral? /    ||  ____ _  _ ____            ||    ##",
	"##                  ,??++?C+!.,    /                                     /     || (_  _) )( (  __)           ||    ##",
	"##                .:^^^^`..zz+?+. / ____________________________________/      ||   )( ) __ () _)            ||    ##",
	"##                .:1^.+,+.Jz?;.!/ /                                           ||  (__)\\_)(_(____)           ||    ##",
	"##                `++J??+8`JJd`.                                               ||  _  _ ____ __    __  __ _  ||    ##",
	"##                .v.! `` 1WHIJWk.                                             || ( \\/ |  __|  )  /  \\(  ( \\ ||    ##",
	"##                 .. ...v?\"TQWHJ;                                             || / \\/ \\) _)/ (_/(  O )    / ||    ##",
	"##                  ..+?! ..vXukzO.                                            || \\_)(_(____)____/\\__/\\_)__) ||    ##",
	"##                 ..  :.jOOZXV=?Cz.                                           ||  ____ _  _  __ ____        ||    ##",
	"##             .  .Hz+&IJzlkAv!Jy+j;                                           || / ___) )( \\/  (  _ \\       ||    ##",
	"##        ..J==?+.Jh+jw?.Ordl..?1iwt      ..J+v.                               || \\___ ) __ (  O ) __/       ||    ##",
	"##    ..,+l?====z1zZujl+xwZSW6.`jXXG..   ====?++                               || (____|_)(_/\\__(__)         ||    ##",
	"##  :..?!?zl===zudVjVXwSOttdXZt. `7Owz1jAO=zzvz?z=:                            ||____________________________||    ##",
	"##      1swXwXVVyY!JvzOOZwOwXSZO, .?UX7juXI`w:1=I=;                                                                ##",
	"##        ?TXXWK^..d$^...`?7?It77=1w. ..zdKzdIIOtt!        ╦ ╦┌─┐┬ ┬  ╔╦╗┌─┐┬┌┬┐┌─┐┬┌─┬ ┬┬                         ##",
	"##    ..J. .XI`JUXf4Va+JJJJO&zl    ?3+z!jbKdkzzIl=o        ╠═╣├┤ └┬┘   ║ ├┤ │ │ │ │├┴┐│ ││                         ##",
	"##  ,1uwuWkyWQAJwX`.dUWWHMM9C7v:     .aggWHS=1?zzzO        ╩ ╩└─┘ ┴    ╩ └─┘┴ ┴ └─┘┴ ┴└─┘o                         ##",
	"##  .wwXHHWfWUHH0^.zwVvwXy+^`^:^.     .THHWZ??=+O=?.       ╦ ╦┌─┐┬─┐┌─┐  ┬ ┬┌┐┌┌┬┐┌─┐┬─┐                           ##",
	"##  wQWWWWffV\"!  .v?`J^??O:.^^.^+        .W0O!11I11.       ║║║├┤ ├┬┘├┤   │ ││││ ││├┤ ├┬┘                            ##",
	"##   `4HY\"!     .A+^`^`^^.^`^.`.+         UWX+jOz1X`       ╚╩╝└─┘┴└─└─┘  └─┘┘└┘─┴┘└─┘┴└─                            ##",
	"##               ?ZOu&J.JJJJvCOf          .XS?Iudpf        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┬┌─┐┌┐┌┬                     ##",
	"##               .1??z'   z+;?+`            11bbW=`        │  │ ││││└─┐ │ ├┬┘│ ││   │ ││ │││││                     ##",
	"##               z???     z;;;!             .c             └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ ┴└─┘┘└┘o                     ##",
	"##              .Oudk,    ???!              ,%             ╔═╗┬ ┬┌─┐┌─┐┬┌─  ┌┐ ┌─┐┌─┐┬┌─  ┬  ┌─┐┌┬┐┌─┐┬─┐┬         ##",
	"##            ...JHbppL  .==:                              ║  ├─┤├┤ │  ├┴┐  ├┴┐├─┤│  ├┴┐  │  ├─┤ │ ├┤ ├┬┘│         ##",
	"##             `dMgHWWWH +?d`                              ╚═╝┴ ┴└─┘└─┘┴ ┴  └─┘┴ ┴└─┘┴ ┴  ┴─┘┴ ┴ ┴ └─┘┴└─o         ##",
	"##           .7\"WHHHWkkS.IO0                                                                                       ##",
	"##               7TUWWUCI??;                                                                                       ##",
	"##                     +z??:                                                                                       ##",
	"##                    .Sz?;  ..f`                                                                                  ##",
	"##                    .Xw2  .SQ,                                                                                   ##",
	"##                    dWSJl.K?\\                                                                                    ##",
	"#####################################################################################################################"
];

// Returns the number of pixels the string will take
// when displayed in monospace font.
// Takes a string. Returns an int.
function charsToPixWidth(string) {
	var pixelWidth = $(".fdsa").width();
	return string.length * pixelWidth;
};
function charLenToPixWidth(integer) {
	var pixelWidth = $(".fdsa").width();
	return integer * pixelWidth;
};
function charsToPixHeight(string) {
	var pixelWidth = $(".fdsa").height();
	return string.length * pixelWidth+integer+1;
};
function charLenToPixHeight(integer) {
	var pixelWidth = $(".fdsa").height();
	return integer * pixelWidth+integer+1;
};
function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}

function kcLolis() {
	var game = this;

	// stats will store all numbers and variables in the game, eg resources and ships and whatnot
	this.stats = {};
	this.stats.fuel = 0;
	this.stats.ammo = 0;
	this.stats.steel = 0;
	this.stats.bauxite = 0;
	this.stats.incrCount = 1;

	// Ascii art vars are one-dimensional arrays with strings that represent the art in question
	// Index 0 represents the top row and index n represents the bottom row. 
	this.ascii = {};

	// this.interactables should have the same vars as this.ascii but instead of an array of the art,
	// the values should consist of the interactables that will handle events such as on_click,
	// the text contained within, class/id/etc information and other information relevant.
	// (x,y) coords are the respective displacements of the top-left corner of the "box"
	// from the upper-left corner of the entire game window, which is (0,0). 
	// width and height represent the w/h of the div box
	this.interactables = {};

	//Art loaded from asciiScreens.js
	this.ascii.navbar = asciiNavbar;
	this.ascii.shop = asciiShop;
	this.ascii.base = asciiBase;

	//Applies to all "frames" of the ascii contained within
	this.ascii.colCount = this.ascii.navbar[0].length;
	this.ascii.rowCount = this.ascii.navbar.length+this.ascii.base.length;
	this.interactables.navbar = {
		"menuButton" : {
			"html":["//////////","// Base //","//////////"],
			"x":4, "y":2,
			"width":10, "height":3,
			"callback":"lolis.mainBase()",
			"classes":["elem-div"],
			"unlocked":true
		}, "shopButton" : {
			"html":["//////////","// Shop //","//////////"],
			"x":19, "y":2,
			"width":10, "height":3,
			"callback":"lolis.mainShop()",
			"classes":["elem-div"],
			"unlocked":true
		}, "sortieButton" : {
			"html":["////////////","//  Farm  //","////////////"],
			"x":34, "y":2,
			"width":12, "height":3,
			"callback":"lolis.mainFarm()",
			"classes":["elem-div"],
			"unlocked":false
		}, "mapButton" : {
			"html":["/////////","// Map //","/////////"],
			"x":51, "y":2,
			"width":9, "height":3,
			"callback":"lolis.mainMap()",
			"classes":["elem-div"],
			"unlocked":false
		}, "farmButton" : {
			"html":["//////////","// Menu //","//////////"],
			"x":65, "y":2,
			"width":10, "height":3,
			"callback":"lolis.mainMenu()",
			"classes":["elem-div"],
			"unlocked":false
		}
	};
	this.currentFrame = {};
	// main, shop, map, farm, menu
	this.currentFrame.screen = "base";
	this.currentFrame.interactables = [this.interactables.navbar];
	this.currentFrame.ascii = this.ascii.base;
	this.currentFrame.asciinavbar = this.ascii.navbar;
	this.currentFrame.render = [];
	// game.currentFrame.changed should only indicate scene changes
	// eg, going from different menus to other menus, different maps, etc. Drastic changes.
	this.currentFrame.changed = true;

	// line is the line as-is with no html. The text to be rendered
	// data is interactable data. Should contain x,y,width,height,html and attributes
	// attributes are
	// - css -> table of css information
	// - class -> array of classes
	// - id -> string
	// Ignore Offset and OffsetToAdd. Being lazy cuz tired.
	this.returnClickableHTMLOffset = 0;
	this.returnClickableHTMLOffsetToAdd = 0;
	this.returnClickableHTML = function(line, subline, data){
		if (typeof(data) === "undefined"){return line };
		if (data.unlocked){
			var span = "<span"
			if (typeof(data) !== "undefined"){
				if (typeof(data["css"]) !== "undefined"){
					span += " style='"
					var stringified = ""
					for (var key in attr["css"]){
						stringified += key + ":" + data["css"][key] + ";"
					};
					span += stringified
					span += "'"
				};
				if (typeof(data["classes"]) !== "undefined"){ 
					span += " class='"
					span += data["classes"].join(" ")
					span += "'"
				};
				if (typeof(data["id"]) !== "undefined"){
					span += " id='"
					span += data["id"]
					span += "'"
				};
				if (typeof(data["callback"]) !== "undefined"){
					span += " onclick='"
					span += data["callback"]
					span += "'"
				};
			};
			span += ">"
			span += subline
			span += "</span>"
			var offset = game.returnClickableHTMLOffset;
			game.returnClickableHTMLOffsetToAdd = span.length-subline.length;
			return line.substring(0,data.x+offset) + span + line.substring(data.x+data.width+offset);
		}
		else{return line;};
	};
	this.foo = function(){alert("a");}
	// clear render
	this.clear = function(){
		$(".elem-div").remove();
		$(".game_area").empty();
		game.currentFrame.render = [];
		game.returnClickableHTMLOffset = 0;
	};
	// draw render
	this.render = function(){
		if (game.currentFrame.changed) {
			// Clear everything
			game.clear();
			game.currentFrame.asciinavbar.forEach(function (data) {
				game.currentFrame.render.push(data);
			});

			game.currentFrame.ascii.forEach(function (data) {
				game.currentFrame.render.push(data);
			});
			game.currentFrame.interactables.forEach(function (data){
				for (var button in data) {
					console.log(button);
					if (data.hasOwnProperty(button)){
						var i = 0;
						var info = data[button];
						for (var buttonLine in info.html) {
							var line = game.currentFrame.render[info.y+i];
							if (typeof(line) === "string"){
								var newline = game.returnClickableHTML(line,info.html[buttonLine],info)
								game.currentFrame.render[info.y+i] = newline
							};
							i++;
						};
						game.returnClickableHTMLOffset += game.returnClickableHTMLOffsetToAdd;
					};
				};
			});
			game.currentFrame.render.forEach(function (data){
				$(".game_area").append(data).append("<br>");
			});
			game.currentFrame.changed = false;
		};
		$("#fuel_count").html(game.renderRescString(game.stats.fuel));
		$("#ammo_count").html(game.renderRescString(game.stats.ammo));
		$("#steel_count").html(game.renderRescString(game.stats.steel));
		$("#bauxite_count").html(game.renderRescString(Math.floor(game.stats.bauxite)));
	};

	this.save = function() {
		var cookieInfo = ""
		cookieInfo += "fuel:"+game.stats.fuel.toString()+"|";
		cookieInfo += "ammo:"+game.stats.ammo.toString()+"|";
		cookieInfo += "steel:"+game.stats.steel.toString()+"|";
		cookieInfo += "bauxite:"+game.stats.bauxite.toString()+"|";
		var d = new Date();
   	 	d.setTime(d.getTime() + (401*19*8*168*58*24*60*60*1000)); // basically the cookie never expires
		document.cookie = "kcLolisInfo="+cookieInfo+";expires="+d.toUTCString();
	};
	this.load = function() {
		var cookie = getCookie("kcLolisInfo");
		var valArray = cookie.split("|");
		valArray.forEach(function (data) {
			var split = data.split(":");
			var key = split[0];
			var val = split[1];
			if (key == "fuel"){game.stats.fuel = Number(val)}
			else if(key == "ammo"){game.stats.ammo = Number(val)}
			else if(key == "steel"){game.stats.steel = Number(val)}
			else if(key == "bauxite"){game.stats.bauxite = Number(val)};
		});
	};

	this.init = function() {

	};

	this.start = function() {
		game.load();
		game.timerLoop();
	};

	this.timerLoop = function() {
		game.rescUpdate();
		game.render();
		game.save();
		setTimeout(game.timerLoop,1000);
	};

	this.rescUpdate = function(){
		game.stats.fuel += game.stats.incrCount;
		game.stats.ammo += game.stats.incrCount;
		game.stats.steel += game.stats.incrCount;
		game.stats.bauxite += game.stats.incrCount/3;
	};
	// returns a padded string of an integer
	this.renderRescString = function(integer){
		var val = numberWithCommas(integer);
		//resources should be 23 chars long, so max pad is 23 chars
		var pad = "                       "
		return pad.substring(0,pad.length-val.length)+val
	};

	this.mainShop = function(){
		game.currentFrame.screen = "shop";
		game.currentFrame.ascii = game.ascii.shop;
		game.currentFrame.interactables = [game.interactables.navbar,game.interactables.shop];
		this.currentFrame.changed = true;
	};
	this.mainBase = function(){
		game.currentFrame.screen = "base";
		game.currentFrame.ascii = game.ascii.base;
		game.currentFrame.interactable = [game.interactables.navbar]
		this.currentFrame.changed = true;
	};
};




var lolis = new kcLolis();

$(document).ready(function () {
	$("<pre/>").css({"position":"absolute","top":"-100px",
				      "font-family":"monospace",
					  "font-size":"11px"}).attr("class","fdsa").html("p").appendTo("body");

	var $gameArea = $(".game_area");
	$gameArea.css({
		"font-family":"monospace",
		"font-size":"11px",
		"color":"#00D316",
		"background":"black"
	});
	lolis.start();
});
console.log("done");