-- Lua filter to process author metadata for Frontiers template

return {
  {
    Meta = function(meta)
      -- Debug output
      io.stderr:write("Frontiers Lua filter: Processing metadata...\n")
      
      -- Process authors if they exist
      if meta.author and #meta.author > 0 then
        io.stderr:write("Frontiers Lua filter: Found " .. #meta.author .. " authors\n")
        local first_author_last = "Author"
        local authors_string = ""
        local corr_author = ""
        local corr_email = ""
        
        -- Process first author
        local first_author = meta.author[1]
        
        -- Extract first author's last name
        local first_given = ""
        local first_family = ""
        
        -- In Quarto, author metadata is structured differently
        -- Let's try to stringify the whole author first
        local first_author_str = pandoc.utils.stringify(first_author)
        io.stderr:write("  First author stringified: '" .. first_author_str .. "'\n")
        
        -- Check if we can access by index (common in Quarto)
        if first_author[1] and first_author[2] then
          first_given = pandoc.utils.stringify(first_author[1])
          first_family = pandoc.utils.stringify(first_author[2])
          io.stderr:write("  Extracted by index - Given: '" .. first_given .. "', Family: '" .. first_family .. "'\n")
          
          first_author_last = first_family
          if #meta.author > 1 then
            first_author_last = first_author_last .. " et~al."
          end
        end
        
        -- Build authors string
        for i, author in ipairs(meta.author) do
          if i > 1 then
            authors_string = authors_string .. ", "
          end
          
          local name = ""
          local given = ""
          local family = ""
          local email = ""
          local is_corresponding = false
          
          -- Try to extract name parts
          if author[1] and author[2] then
            given = pandoc.utils.stringify(author[1])
            family = pandoc.utils.stringify(author[2])
            name = given .. " " .. family
          else
            -- Fallback: stringify the whole author
            name = pandoc.utils.stringify(author)
          end
          
          -- Try to get email (might be at index 3)
          if author[3] then
            email = pandoc.utils.stringify(author[3])
            io.stderr:write("  Found email at index 3: '" .. email .. "'\n")
          end
          
          io.stderr:write("  Author " .. i .. " name: '" .. name .. "'\n")
          
          authors_string = authors_string .. name .. "\\,\\textsuperscript{1"
          
          -- For now, assume first author is corresponding if only one author
          -- or if it has an email
          if (i == 1 and email ~= "") or #meta.author == 1 then
            authors_string = authors_string .. ",*"
            corr_author = name
            corr_email = email
          end
          
          authors_string = authors_string .. "}"
        end
        
        -- Set metadata using pandoc MetaInlines
        if first_author_last ~= "" then
          meta["frontiers-first-author-last"] = pandoc.MetaInlines{pandoc.Str(first_author_last)}
        end
        if authors_string ~= "" then
          meta["frontiers-authors-string"] = pandoc.MetaInlines{pandoc.RawInline("latex", authors_string)}
        end
        if corr_author ~= "" then
          meta["frontiers-corr-author"] = pandoc.MetaInlines{pandoc.Str(corr_author)}
        end
        if corr_email ~= "" then
          meta["frontiers-corr-email"] = pandoc.MetaInlines{pandoc.Str(corr_email)}
        end
      end
      
      return meta
    end
  }
}