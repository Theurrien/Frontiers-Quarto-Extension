-- Debug filter to print metadata structure
return {
  {
    Meta = function(meta)
      io.stderr:write("=== DEBUG METADATA ===\n")
      
      -- Check by-author
      if meta["by-author"] then
        io.stderr:write("Found by-author metadata\n")
        local by_author = meta["by-author"]
        for i, author in ipairs(by_author) do
          io.stderr:write("Author " .. i .. ":\n")
          io.stderr:write("  Type: " .. type(author) .. "\n")
          -- Try to access properties
          if author.name then
            io.stderr:write("  Has name property\n")
            if author.name.given then
              io.stderr:write("  Given: " .. pandoc.utils.stringify(author.name.given) .. "\n")
            end
            if author.name.family then
              io.stderr:write("  Family: " .. pandoc.utils.stringify(author.name.family) .. "\n")
            end
          end
        end
      else
        io.stderr:write("No by-author metadata found\n")
      end
      
      -- Check regular author
      if meta.author then
        io.stderr:write("\nFound author metadata\n")
        io.stderr:write("Number of authors: " .. #meta.author .. "\n")
      end
      
      io.stderr:write("=== END DEBUG ===\n")
      return meta
    end
  }
}