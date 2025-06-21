-- Citation Sort Filter for Frontiers Harvard Extension
-- Sorts multiple citations alphabetically within citation groups
-- Author: Claude Code Assistant
-- Version: 1.0

local function compare_citations(a, b)
  -- Extract citation keys for comparison
  local key_a = a.id or ""
  local key_b = b.id or ""
  
  -- Convert to lowercase for case-insensitive comparison
  return key_a:lower() < key_b:lower()
end

local function sort_citation_group(citations)
  -- Sort the citations array alphabetically by citation key
  table.sort(citations, compare_citations)
  return citations
end

function Cite(cite)
  -- Only process if there are multiple citations
  if #cite.citations > 1 then
    -- Sort the citations alphabetically
    cite.citations = sort_citation_group(cite.citations)
  end
  
  return cite
end

-- Return the filter
return {
  {
    Cite = Cite
  }
}