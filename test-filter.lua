-- Test filter to debug metadata processing

function Meta(meta)
  -- Write debug info to stderr
  io.stderr:write("=== TEST FILTER RUNNING ===\n")
  
  if meta.author then
    io.stderr:write("Author metadata found\n")
    io.stderr:write("Number of authors: " .. #meta.author .. "\n")
    
    for i, author in ipairs(meta.author) do
      io.stderr:write("Author " .. i .. ":\n")
      if author.name then
        if author.name.given then
          io.stderr:write("  Given: " .. pandoc.utils.stringify(author.name.given) .. "\n")
        end
        if author.name.family then
          io.stderr:write("  Family: " .. pandoc.utils.stringify(author.name.family) .. "\n")
        end
      end
    end
  else
    io.stderr:write("No author metadata found\n")
  end
  
  -- Set a simple test variable
  meta["test-variable"] = pandoc.MetaString("This is a test")
  
  return meta
end