package fileIO;
import editorView.PathBoxer;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import haxe.Constraints.Function;
import haxe.Json;
import model.Path;
import model.Wave;
import model.Waypoint;
import openfl.display.Bitmap;
import openfl.display.Loader;
import openfl.display.LoaderInfo;
import openfl.events.Event;
import openfl.net.FileFilter;
import openfl.net.FileReference;

/**
 * ...
 * @author Oelson
 */
class JsonIO
{
	private var callback:Function;

	public function new(callback:Function) 
	{
		this.callback = callback;
	}
	
	
	public function browse() 
	{
		var fr:FileReference = new FileReference();
		var filters:Array<FileFilter> = new Array<FileFilter>();
		filters.push(new FileFilter("JSON File", "*.json"));
		fr.browse(filters);
		fr.addEventListener(Event.SELECT, onSelect);
	}
	
	private function onSelect(e:Event):Void 
	{
		var fr:FileReference = cast(e.target, FileReference);
		fr.addEventListener(Event.COMPLETE, onLoad);
		fr.load();
	}
	
	private function onLoad(e:Event):Void 
	{
		var fr:FileReference = e.target;
		fr.removeEventListener(Event.COMPLETE, onLoad);
		
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoad);
		loader.loadBytes(fr.data);
	}
	
	private function onImgLoad(e:Event):Void 
	{
		var loaderInfo:LoaderInfo = e.target;
		loaderInfo.removeEventListener(Event.COMPLETE, onImgLoad);
		var bmp:Bitmap = cast(loaderInfo.content, Bitmap);
		callback(bmp.bitmapData, loaderInfo.url);
	}
	
	public function save(waves:FlxTypedGroup<Wave>)
	{
		//var json:String = Json.stringify(waves);
		var json:String;
		json = "{\"waves\":[";
		for (i in 0...waves.length)
		{
			//json.waves[i] = "Wave" + i;
			json += "{\"wave\":[";
			var wave:Wave = waves.members[i];
			for (j in 0...wave.length)
			{
				json += "{\"path\":[";
				var path:Path = wave.members[j];
				for (k in 0...path.length)
				{
					var wp:Waypoint = path.members[k];
					json += "{\"waypoint\":{";
					json += "\"xPer\":" + wp.xPer;
					json += ",\"yPer\":" + wp.yPer;
					json += ",\"rotation\":" + wp.rotation;
					json += ",\"rateOfFire\":" + wp.rateOfFire;
					json += ",\"speed\":" + wp.speed;
					json += ",\"wait\":" + wp.wait;
					json += ",\"numShips\":" + wp.numShips;
					json += ",\"interval\":" + wp.interval;
					json += "}}";
					if (k < path.length - 1) json += ",";
				}
				json += "]}";
				if (j < wave.length - 1) json += ",";
			}
			json += "]}";
			if (i < waves.length - 1) json += ",";
		}
		json += "]}";
		
		//var waver:FlxTypedGroup<Wave> = new FlxTypedGroup<Wave>();
		//var wave:Wave = new Wave();
		//var path:Path = new Path();
		//var wp:Waypoint = new Waypoint();
		//wp.xPer = 39;
		//wp.yPer = 59;
		//path.add(wp);
		//wave.add(path);
		//waver.add(wave);
		//json = Json.stringify(waver, replacer,"     ");
		var jsonDyn:Dynamic = Json.parse(json);
		var jsonCheck:String = Json.stringify(jsonDyn, null, "    ");
		FlxG.log.add("json");
		FlxG.log.add(jsonCheck);
	}
	
	private function replacer(key:Dynamic, value:Dynamic):Dynamic {
		FlxG.log.add("keyvalue: "+ key + " ----> " + value);
		if (key == "members" || key == "xPer" || key == "rotation") {
			return value;
		}
		return "";
	}
}