package feed.atom;

class Atom {
	public var authors: Array<Person> = [];
	public var categories: Array<Category> = [];
	public var contributors: Array<Person> = [];
	public var entries: Array<Entry> = [];
	public var generator: Generator;
	public var icon: String;
	public var id: String;
	public var link: Link;
	public var logo: String;
	public var rights: Text;
	public var subtitle: Text;
	public var title: Text;
	public var updated: String;

	public function new() {}
}

class Entry {
	public var authors: Array<Person> = [];
	public var categories: Array<Category> = [];
	public var content: Content;
	public var contributors: Array<Person> = [];
	public var id: String;
	public var link: Link;
	public var published: String;
	public var rights: Text;
	public var source: Source;
	public var summary: Text;
	public var title: Text;
	public var updated: String;

	public function new() {}
}

typedef Category = {
	label: String,
	scheme: String,
	term: String,
}

typedef Content = {
	src: String,
	type: String,
	value: String,
}

typedef Generator = {
	uri: String,
	value: String,
	version: String,
}

typedef Link = {
	href: String,
	hreflang: String,
	length: Null<Int>,
	rel: String,
	title: String,
	type: String,
}

typedef Person = {
	email: String,
	name: String,
	uri: String,
}

typedef Source = {
	id: String,
	title: Text,
	updated: String,
}

typedef Text = {
	type: String,
	value: String,
}
