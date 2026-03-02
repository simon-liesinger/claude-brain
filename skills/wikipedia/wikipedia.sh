#!/usr/bin/env bash
# Fetch Wikipedia articles as plain text via the official MediaWiki API.
# Usage:
#   wikipedia.sh "Article Title"        — fetch full article
#   wikipedia.sh -s "search query"      — search for articles
#   wikipedia.sh -i "Article Title"     — intro only (summary)
#   wikipedia.sh -l fr "Article Title"  — fetch from French Wikipedia (default: en)

set -euo pipefail

UA="kim-claude-code/1.0 (https://github.com/kim-em)"
LANG_CODE="en"
MODE="full"

usage() {
  echo "Usage: wikipedia.sh [-s] [-i] [-l LANG] <title or query>"
  echo "  -s   Search for articles matching query"
  echo "  -i   Intro/summary only"
  echo "  -l   Language code (default: en)"
  exit 1
}

while getopts "sil:" opt; do
  case "$opt" in
    s) MODE="search" ;;
    i) MODE="intro" ;;
    l) LANG_CODE="$OPTARG" ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))

[ $# -eq 0 ] && usage

QUERY="$*"
BASE="https://${LANG_CODE}.wikipedia.org/w/api.php"

case "$MODE" in
  search)
    curl -s -H "User-Agent: $UA" \
      --get "$BASE" \
      --data-urlencode "action=opensearch" \
      --data-urlencode "format=json" \
      --data-urlencode "search=$QUERY" \
      --data-urlencode "limit=10" \
      | python3 -c "
import json, sys
data = json.load(sys.stdin)
titles, _, urls = data[1], data[2], data[3]
for t, u in zip(titles, urls):
    print(f'{t}')
    print(f'  {u}')
"
    ;;
  intro)
    curl -s -H "User-Agent: $UA" \
      --get "$BASE" \
      --data-urlencode "action=query" \
      --data-urlencode "format=json" \
      --data-urlencode "titles=$QUERY" \
      --data-urlencode "prop=extracts" \
      --data-urlencode "exintro=1" \
      --data-urlencode "explaintext=1" \
      --data-urlencode "redirects=1" \
      | python3 -c "
import json, sys
data = json.load(sys.stdin)
pages = data['query']['pages']
for pid, page in pages.items():
    if pid == '-1':
        print(f'Page not found: {page.get(\"title\", \"unknown\")}')
        sys.exit(1)
    print(f'# {page[\"title\"]}')
    print(f'https://${LANG_CODE}.wikipedia.org/wiki/{page[\"title\"].replace(\" \", \"_\")}')
    print()
    print(page.get('extract', '(no content)'))
"
    ;;
  full)
    curl -s -H "User-Agent: $UA" \
      --get "$BASE" \
      --data-urlencode "action=query" \
      --data-urlencode "format=json" \
      --data-urlencode "titles=$QUERY" \
      --data-urlencode "prop=extracts" \
      --data-urlencode "explaintext=1" \
      --data-urlencode "redirects=1" \
      | python3 -c "
import json, sys
data = json.load(sys.stdin)
pages = data['query']['pages']
for pid, page in pages.items():
    if pid == '-1':
        print(f'Page not found: {page.get(\"title\", \"unknown\")}')
        sys.exit(1)
    print(f'# {page[\"title\"]}')
    print(f'https://${LANG_CODE}.wikipedia.org/wiki/{page[\"title\"].replace(\" \", \"_\")}')
    print()
    print(page.get('extract', '(no content)'))
"
    ;;
esac
