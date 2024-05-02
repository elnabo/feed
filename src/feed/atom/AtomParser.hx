package feed.atom;

import feed.atom.Atom.Entry;
import feed.utils.Error;
import feed.utils.ParsingUtils.extractRoot;
import haxe.xml.Access;

using feed.atom.AtomParser;

class AtomParser {
	public static function parse(data:String) {
		final feed = extractRoot(data);
		if (feed.name != 'feed') {
			throw Error.InvalidAtom;
		}

		final atom = new Atom();

		for (elt in feed.elements) {
			switch(elt.name) {
				case 'author':
					atom.authors.push(elt.parsePerson());
				case 'category':
					atom.categories.push(elt.parseCategory());
				case 'contributor':
					atom.contributors.push(elt.parsePerson());
				case 'entry':
					atom.entries.push(elt.parseEntry());
				case 'generator':
					atom.generator = {
						uri: elt.x.get('uri'),
						value: elt.innerData,
						version: elt.x.get('version'),
					}
				case 'icon':
					atom.icon = elt.innerData;
				case 'id':
					atom.id = elt.innerData;
				case 'link':
					atom.link = elt.parseLink();
				case 'logo':
					atom.logo = elt.innerData;
				case 'rights':
					atom.rights = elt.parseText();
				case 'subtitle':
					atom.rights = elt.parseText();
				case 'title':
					atom.title = elt.parseText();
				case 'updated':
					atom.updated = elt.innerData;
			}
		}
		return atom;
	}

	static function parseCategory(elt:Access) {
		return {
			label: elt.hasNode.label ? elt.node.label.innerData : null,
			scheme: elt.hasNode.scheme ? elt.node.scheme.innerData : null,
			term: elt.node.term.innerData,
		}
	}

	static function parseContent(elt:Access) {
		final type = elt.x.get('type');
		return {
			src: elt.x.get('src'),
			type: type,
			value: type == 'text' ? elt.innerData : elt.innerHTML,
		};
	}

	static function parseEntry(entryElt:Access) {
		final entry = new Entry();

		for (elt in entryElt.elements) {
			switch (elt.name) {
				case 'author':
					entry.authors.push(elt.parsePerson());
				case 'category':
					entry.categories.push(elt.parseCategory());
				case 'content':
					entry.content = elt.parseContent();
				case 'contributor':
					entry.contributors.push(elt.parsePerson());
				case 'id':
					entry.id = elt.innerData;
				case 'link':
					entry.link = elt.parseLink();
				case 'published':
					entry.published = elt.innerData;
				case 'rights':
					entry.rights = elt.parseText();
				case 'source':
					entry.source = {
						id: elt.node.id.innerData,
						title: elt.node.title.parseText(),
						updated: elt.node.updated.innerData,
					}
				case 'summary':
					entry.summary = elt.parseText();
				case 'title':
					entry.title = elt.parseText();
				case 'updated':
					entry.updated = elt.innerData;
			}
		}

		return entry;
	}

	static function parseLink(elt:Access) {
		return {
			href: elt.att.href,
			hreflang: elt.x.get('hreflang'),
			length: elt.has.length ? Std.parseInt(elt.att.length) : null,
			rel: elt.x.get('rel'),
			title: elt.x.get('title'),
			type: elt.x.get('type'),
		};
	}

	static function parsePerson(elt:Access) {
		return {
			email: elt.hasNode.email ? elt.node.email.innerData : null,
			name: elt.node.name.innerData,
			uri: elt.hasNode.uri ? elt.node.uri.innerData : null,
		}
	}

	static function parseText(elt:Access) {
		final type = elt.x.get('type');
		return {
			type: type,
			value: type == 'text' ? elt.innerData : elt.innerHTML,
		};
	}
}
