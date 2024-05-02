package feed.rss;

class RSS {
	public var category: Category;
	public var cloud: Cloud;
	public var copyright: String;
	public var description: String;
	public var docs: String;
	public var generator: String;
	public var image: Image;
	public var items: Array<Item> = [];
	public var language: String;
	public var lastBuildDate: String;
	public var link: String;
	public var managingEditor: String;
	public var pubDate: String;
	public var rating: String;
	public var skipDays: Array<Day> = [];
	public var skipHours: Array<Hour> = [];
	public var textInput: TextInput;
	public var title: String;
	public var ttl: Null<Int>;
	public var webMaster: String;

	public function new() {}
}

class Item {
	public var author: String;
	public var category: Category;
	public var comments: String;
	public var description: String;
	public var enclosure: Enclosure;
	public var guid: String;
	public var link: String;
	public var pubDate: String;
	public var source: String;
	public var title: String;

	public function new() {}
}

typedef Category = {
	domain: String,
	value: String,
}

typedef Cloud = {
	domain: String,
	path: String,
	port: String,
	protocol: String,
	registerProcedure: String,
}

@:enum
abstract Day(String) to String {
	final Friday = 'Friday';
	final Monday = 'Monday';
	final Saturday = 'Saturday';
	final Sunday = 'Sunday';
	final Thursday = 'Thursday';
	final Tuesday = 'Tuesday';
	final Wednesday = 'Wednesday';

	public static function from(s:String) {
		return switch(s) {
			case Day.Friday: Friday;
			case Day.Monday: Monday;
			case Day.Saturday: Saturday;
			case Day.Sunday: Sunday;
			case Day.Thursday: Thursday;
			case Day.Tuesday: Tuesday;
			case Day.Wednesday: Wednesday;
			default: throw feed.utils.Error.InvalidValue(s, 'Day');
		}
	}
}

typedef Enclosure = {
	length: Int,
	type: String,
	url: String,
}

abstract Hour(Int) to Int {
	public function new(s:String) {
		if (s == null) {
			throw feed.utils.Error.InvalidValue(s, 'Hour');
		}

		final h = Std.parseInt(s);
		if (h == null || h < 0 || h > 23) {
			throw feed.utils.Error.InvalidValue(s, 'Hour');
		}
		this = h;
	}
}

typedef Image = {
	height: Null<Int>,
	link: String,
	title: String,
	url: String,
	width: Null<Int>,
}

typedef TextInput = {
	description: String,
	link: String,
	name: String,
	title: String,
}
