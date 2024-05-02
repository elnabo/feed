package feed.utils;

enum Error {
	InvalidAtom;
	InvalidNode(name:String, xml:String);
	InvalidRSS;
	InvalidValue(value:String, type:String);
	InvalidXML;
	NoData;
	UnknownFeed;
}
