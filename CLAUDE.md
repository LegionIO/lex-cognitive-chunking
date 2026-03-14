# lex-cognitive-chunking

**Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

George Miller's 7+/-2 principle: groups information items into hierarchical chunks to model working memory capacity. Items are added to a pool, grouped into named chunks, and loaded into a bounded working memory (capacity: 7 +/- 2). Chunks can be merged hierarchically, and recall strength decays over time.

## Gem Info

- **Gem name**: `lex-cognitive-chunking`
- **Version**: `0.1.0`
- **Module**: `Legion::Extensions::CognitiveChunking`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_chunking/
  cognitive_chunking.rb
  version.rb
  client.rb
  helpers/
    constants.rb
    chunking_engine.rb
    chunk.rb
    information_item.rb
  runners/
    cognitive_chunking.rb
```

## Key Constants

From `helpers/constants.rb`:

- `WORKING_MEMORY_CAPACITY` = `7` (Miller's magic number)
- `CAPACITY_VARIANCE` = `2` (+/- 2, so range 5-9)
- `MAX_ITEMS` = `500`, `MAX_CHUNKS` = `200`
- `DEFAULT_COHERENCE` = `0.5`, `COHERENCE_BOOST` = `0.08`, `COHERENCE_DECAY` = `0.03`
- `RECALL_DECAY` = `0.02`, `RECALL_BOOST` = `0.1`
- `CHUNK_SIZE_LABELS` — `7+` = `:large`, `5-6` = `:medium`, `3-4` = `:small`, below = `:micro`
- `COHERENCE_LABELS` — `0.8+` = `:tightly_chunked` through below `0.2` = `:unchunked`
- `RECALL_LABELS` — `0.8+` = `:instant` through below `0.2` = `:forgotten`
- `CAPACITY_LABELS` — `0.8+` = `:overloaded`, `0.6` = `:near_capacity`, `0.4` = `:comfortable`, `0.2` = `:spacious`, below = `:empty`

## Runners

All methods in `Runners::CognitiveChunking`:

- `add_item(content:, domain: :general)` — adds a raw information item to the pool; returns `item_id`
- `create_chunk(label:, item_ids:)` — groups items into a named chunk; checks coherence of grouping
- `merge_chunks(chunk_ids:, label:)` — combines multiple chunks into a higher-level chunk
- `load_to_working_memory(chunk_id:)` — loads a chunk into working memory; fails if overloaded
- `unload_from_working_memory(chunk_id:)` — removes a chunk from working memory
- `working_memory_status` — current size, capacity, load, label, overloaded flag
- `decay_all` — applies recall decay to all chunks (call periodically)
- `reinforce_chunk(chunk_id:)` — applies recall boost to a chunk
- `chunking_report` — full report: items, chunks, efficiency, working memory state
- `strongest_chunks(limit: 10)` — top chunks by recall strength
- `unchunked_items` — items not yet assigned to any chunk

## Helpers

- `ChunkingEngine` — manages items, chunks, and working memory set. Computes `working_memory_load` as `wm_size / WORKING_MEMORY_CAPACITY`. `chunking_efficiency` = ratio of chunked items to total items.
- `Chunk` — named group of item IDs with `coherence` and `recall_strength`. Methods: `reinforce!`, `decay!`, `merge_from!(other_chunks)`.
- `InformationItem` — individual piece of content with `domain`, `created_at`. Items are unchunked until assigned.

## Integration Points

- `lex-memory` handles long-term trace storage; chunking models the short-term working memory buffer that feeds into memory consolidation.
- During `lex-tick` processing, chunking limits how many distinct items the agent holds in active consideration — a natural constraint that prevents cognitive overload modeling.
- `merge_chunks` supports hierarchical chunking: raw items -> small chunks -> concept chunks -> schema chunks, each layer reducing the working memory footprint.

## Development Notes

- Working memory is capped at `WORKING_MEMORY_CAPACITY` (7) by design. `working_memory_overloaded?` fires when size >= capacity.
- `decay_all` is the maintenance runner; `reinforce_chunk` is called when a chunk is accessed or recalled.
- Unchunked items do not decay (only chunks decay). Items accumulate until chunked or manually pruned.
- An existing README exists at the repo root (brief usage example with chess opening moves).
