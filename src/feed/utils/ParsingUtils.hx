package feed.utils;

import haxe.xml.Access;

function extractRoot(data:String) {
	if (data == null || data.length == 0) {
		throw Error.NoData;
	}

	try {
		final xml = Xml.parse(data);
		final root = xml.firstElement();
		if (root == null) {
			throw Error.NoData;
		}

		return new Access(root);
	}
	catch(_) {
		throw Error.InvalidXML;
	}
}
