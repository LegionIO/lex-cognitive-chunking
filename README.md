# lex-cognitive-chunking

LEX extension for LegionIO implementing George Miller's 7+/-2 cognitive chunking principle.

Groups individual information items into meaningful chunks, supports hierarchical chunk merging, and models working memory capacity constraints.

## Installation

```ruby
gem 'lex-cognitive-chunking'
```

## Usage

```ruby
client = Legion::Extensions::CognitiveChunking::Client.new

r1 = client.add_item(content: 'e4 e5', domain: :chess)
r2 = client.add_item(content: 'Nf3 Nc6', domain: :chess)
r3 = client.add_item(content: 'Bb5', domain: :chess)

chunk = client.create_chunk(
  label: 'Ruy Lopez opening',
  item_ids: [r1[:item_id], r2[:item_id], r3[:item_id]]
)

client.load_to_working_memory(chunk_id: chunk[:chunk_id])
client.chunking_report
```

## License

MIT
