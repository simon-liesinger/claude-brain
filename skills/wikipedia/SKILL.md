# Wikipedia

Look up Wikipedia articles using the official MediaWiki API. Use when the user asks about a topic where Wikipedia would be a good reference, or when you need factual background information and WebFetch is blocked by Wikipedia's bot detection.

## Usage

```bash
# Full article
~/.claude/skills/wikipedia/wikipedia.sh "Article Title"

# Intro/summary only (shorter, often sufficient)
~/.claude/skills/wikipedia/wikipedia.sh -i "Article Title"

# Search for articles
~/.claude/skills/wikipedia/wikipedia.sh -s "search query"

# Other language editions
~/.claude/skills/wikipedia/wikipedia.sh -l fr "Théorie des types"
```

## Notes

- Uses the official MediaWiki Action API (`action=query`, `prop=extracts`, `explaintext`)
- No authentication required, no rate limit on reads (just be reasonable)
- Returns plain text (no wikitext markup, no HTML)
- Full articles can be very long; use `-i` for summaries when that's sufficient
- Handles redirects automatically (`redirects=1`)
