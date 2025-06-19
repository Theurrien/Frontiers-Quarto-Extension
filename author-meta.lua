-- Lua filter to extract author metadata for Frontiers template

function Meta(meta)
  -- Process authors
  if meta.author then
    local authors = {}
    local first_author_last = ""
    local corr_author = ""
    local corr_email = ""
    
    -- Handle both single author and multiple authors
    local author_list = meta.author
    if author_list.t == "MetaInlines" then
      -- Single author as string
      author_list = {author_list}
    end
    
    for i, author in ipairs(author_list) do
      local author_str = ""
      local is_corresponding = false
      
      if author.name then
        -- Structured author data
        if author.name.given and author.name.family then
          author_str = pandoc.utils.stringify(author.name.given) .. " " .. pandoc.utils.stringify(author.name.family)
          if i == 1 then
            first_author_last = pandoc.utils.stringify(author.name.family)
          end
        end
        
        if author.attributes and author.attributes.corresponding then
          is_corresponding = true
          corr_author = author_str
          if author.email then
            corr_email = pandoc.utils.stringify(author.email)
          end
        end
      else
        -- Simple string author
        author_str = pandoc.utils.stringify(author)
        if i == 1 then
          -- Extract last name (assume last word)
          local words = {}
          for word in author_str:gmatch("%S+") do
            table.insert(words, word)
          end
          if #words > 0 then
            first_author_last = words[#words]
          end
        end
      end
      
      table.insert(authors, {
        name = author_str,
        is_corresponding = is_corresponding
      })
    end
    
    -- Set metadata for template
    if #authors > 0 then
      meta["frontiers-authors"] = authors
      meta["frontiers-first-author-last"] = first_author_last
      if #authors > 1 then
        meta["frontiers-first-author-last"] = first_author_last .. " et~al."
      end
      meta["frontiers-corr-author"] = corr_author ~= "" and corr_author or authors[1].name
      meta["frontiers-corr-email"] = corr_email ~= "" and corr_email or "test@example.com"
    end
  end
  
  return meta
end