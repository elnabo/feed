# feed - Parsers and type definitions for Atom and RSS files

## Atom
```haxe
var data = '
	<?xml version="1.0" encoding="UTF-8"?>
	<feed>
		<title>Example Title</title>
		<subtitle>Example subtitle.</subtitle>
		<link href="http://example.org/feed/" rel="self" />
		<id>urn:uuid:555555555-2222-1111-aaaa-000000000000</id>
		<updated>2024-04-28T12:00:00Z</updated>

		<entry>
			<title>Example entry</title>
			<link href="http://www.example.com/entry/1" />
			<id>urn:uuid:555555555-2222-1111-aaaa-000000000001</id>
			<published>2024-04-26T12:00:00Z</published>
			<updated>2024-04-27T12:00:00Z</updated>
			<summary>Some interesting description.</summary>
		</entry>
	</feed>
'
var atom = feed.atom.AtomParser.parse(data);
trace(atom.title); // Example Title
trace(atom.entry[0].link.href); // Some interesting description.
```

## RSS
```haxe
var data = '
	<?xml version="1.0" encoding="UTF-8"?>
	<rss version="2.0">
	<channel>
		<title>Example Title</title>
		<description>Example of an RSS feed</description>
		<link>http://www.example.com/main.html</link>

		<item>
			<title>Example entry</title>
			<description>Some interesting description.</description>
			<link>http://www.example.com/entry/1</link>
			<pubDate>Sun, 28 Apr 2024 12:00:00 +0000</pubDate>
		</item>
	</channel>
	</rss>
';
var rss = feed.rss.RSSParser.parse(data);
trace(rss.title); // Example Title
trace(rss.items[0].link); // Some interesting description.
```
