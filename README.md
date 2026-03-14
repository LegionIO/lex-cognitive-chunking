# lex-cognitive-chunking

LEX extension for LegionIO implementing George Miller's 7+/-2 cognitive chunking principle. Groups individual information items into meaningful chunks and models working memory capacity constraints.

## What It Does

Raw information items are pooled and then grouped into named chunks. Chunks can be merged hierarchically (items -> concepts -> schemas) to reduce working memory footprint. A bounded working memory holds up to 7 chunks (capacity varies +/- 2); loading beyond capacity triggers an overloaded state. Recall strength decays over time; reinforcement on access keeps important chunks alive.

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
client.working_memory_status
# => { size: 1, capacity: 7, load: 0.14, label: :spacious, overloaded: false }

client.decay_all           # call periodically for recall decay
client.reinforce_chunk(chunk_id: chunk[:chunk_id])  # boost on access
client.chunking_report
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
