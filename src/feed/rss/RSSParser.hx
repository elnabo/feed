package feed.rss;

import feed.utils.Error;
import feed.utils.ParsingUtils.extractRoot;
import haxe.xml.Access;

class RSSParser {
	static function extractChannel(data:String) {
		var rss = extractRoot(data);
		if (rss.name != 'rss') {
			throw Error.InvalidRSS;
		}

		if (rss.hasNode.channel) {
			return rss.node.channel;
		}

		throw Error.InvalidRSS;
	}

	public static function parse(data:String) {
		final channel = RSSParser.extractChannel(data);

		final rss = new RSS();

		var currElt:Access = null;
		try {
			for (elt in channel.elements) {
				currElt = elt;
				switch (elt.name) {
					case 'category':
						rss.category = {
							domain: elt.x.get('domain'),
							value: elt.innerData,
						};
					case 'cloud':
						rss.cloud = {
							domain: elt.x.get('domain'),
							registerProcedure: elt.x.get('registerProcedure'),
							protocol: elt.x.get('protocol'),
							port: elt.x.get('port'),
							path: elt.x.get('path'),
						}
					case 'copyright':
						rss.copyright = elt.innerData;
					case 'description':
						rss.description = elt.innerData;
					case 'docs':
						rss.description = elt.innerData;
					case 'generator':
						rss.generator = elt.innerData;
					case 'image':
						rss.image = {
							height: elt.hasNode.height ? Std.parseInt(elt.node.height.innerData) : null,
							link: elt.node.link.innerData,
							title: elt.node.title.innerData,
							url: elt.node.url.innerData,
							width: elt.hasNode.width ? Std.parseInt(elt.node.width.innerData) : null,
						};
					case 'item':
						rss.items.push(RSSParser.parseItem(elt));
					case 'language':
						rss.language = elt.innerData;
					case 'lastBuildDate':
						rss.lastBuildDate = elt.innerData;
					case 'link':
						rss.link = elt.innerData;
					case 'managingEditor':
						rss.managingEditor = elt.innerData;
					case 'pubDate':
						rss.pubDate = elt.innerData;
					case 'rating':
						rss.rating = elt.innerData;
					case 'skipDays':
						for (d in elt.nodes.day) {
							rss.skipDays.push(RSS.Day.from(d.innerData));
						}
					case 'skipHours':
						for (h in elt.nodes.hour) {
							rss.skipHours.push(new RSS.Hour(h.innerData));
						}
					case 'title':
						rss.title = elt.innerData;
					case 'ttl':
						rss.ttl = Std.parseInt(elt.innerData);
					case 'webMaster':
						rss.webMaster = elt.innerData;
				}
			}
			return rss;
		}
		catch (_) {
			throw Error.InvalidNode(currElt.name, currElt.innerHTML);
		}
	}

	static function parseItem(itemElt:Access) {
		final item = new RSS.Item();

		for (elt in itemElt.elements) {
			switch (elt.name) {
				case 'author':
					item.author = elt.innerData;
				case 'category':
					item.category = {
						domain: elt.x.get('domain'),
						value: elt.innerData,
					};
				case 'comments':
					item.comments = elt.innerData;
				case 'description':
					item.description = elt.innerData;
				case 'enclosure':
					item.enclosure = {
						length: Std.parseInt(elt.att.length),
						url: elt.att.url,
						type: elt.att.type,
					};
				case 'guid':
					item.guid = elt.innerData;
				case 'link':
					item.link = elt.innerData;
				case 'pubDate':
					item.pubDate = elt.innerData;
				case 'source':
					item.source = elt.innerData;
				case 'title':
					item.title = elt.innerData;
			}
		}
		return item;
	}
}
