" Palette generator for highlighting colors

function s:SetColorset(colorset_name, mode)
  if a:colorset_name == "basic"
    if a:mode == "dark"
      let s:red = { "gui": "#E06C75"} 
      let s:redprime = { "gui": "#ff3c36"}
      let s:redfill = { "gui": "#450c01"}
      
      let s:pink = { "gui": "#f56cc3"} 
      let s:pinkprime = { "gui": "#f547a7"}
      let s:pinkfill = { "gui": "#7a2f5f"}

      let s:green = { "gui": "#98C379"}
      let s:greenprime = { "gui": "#6d9650"}
      let s:greenfill = { "gui": "#044501"}

      let s:yellow = { "gui": "#E5C07b"}
      let s:yellowprime = { "gui": "#ebbd34"}
      let s:yellowfill = { "gui": "#454101"}

      let s:orange = { "gui": "#ffab52"}
      let s:orangeprime = { "gui": "#ff8605"}
      let s:orangefill = { "gui": "#452601"}

      let s:blue = { "gui": "#61AFEF"} 
      let s:blueprime = { "gui": "#5690f5"}
      let s:bluefill = { "gui": "#030145"}

      let s:purple = { "gui": "#ca96f2"} 
      let s:purpleprime = { "gui": "#C678DD"} 
      let s:purplefill = { "gui": "#340145"} 

      let s:cyan = { "gui": "#56B6C2"} 
      let s:cyanprime = { "gui": "#45e1f5"} 
      let s:cyanfill = { "gui": "#014541"} 

      " aft = background, fore = forground
      let s:aft = { "gui": "#333333"}
      let s:aftstrong = { "gui": "#000000"}
      let s:aftweak = { "gui": "#555555"}
      let s:fore = { "gui": "#dddddd"}
      let s:forestrong = { "gui": "#ffffff"}
      let s:foreweak = { "gui": "#aaaaaa"}

    elseif a:mode == "light"
      let s:red = { "gui": "#6e2e2c"} 
      let s:redprime = { "gui": "#ad0c07"}
      let s:redfill = { "gui": "#f5d0ce"}
      
      let s:pink = { "gui": "#a11b7b"} 
      let s:pinkprime = { "gui": "#f2079c"}
      let s:pinkfill = { "gui": "#f7c3e9"}


      let s:green = { "gui": "#448216"}
      let s:greenprime = { "gui": "#3b8c00"}
      let s:greenfill = { "gui": "#d4f5ce"}

      let s:yellow = { "gui": "#63621f"}
      let s:yellowprime = { "gui": "#808205"}
      let s:yellowfill = { "gui": "#f5f4ce"}

      let s:orange = { "gui": "#82511d"}
      let s:orangeprime = { "gui": "#ba6102"}
      let s:orangefill = { "gui": "#f5e5ce"}

      let s:blue = { "gui": "#244580"} 
      let s:blueprime = { "gui": "#033a99"}
      let s:bluefill = { "gui": "#ced5f5"}

      let s:purple = { "gui": "#77328c"} 
      let s:purpleprime = { "gui": "#6f0091"} 
      let s:purplefill = { "gui": "#e6cef5"} 

      let s:cyan = { "gui": "#23555c"} 
      let s:cyanprime = { "gui": "#047180"} 
      let s:cyanfill = { "gui": "#b5fffb"} 

      " aft = background, fore = foreground
      let s:aft = { "gui": "#ffffff"}
      let s:aftstrong = { "gui": "#dddddd"}
      let s:aftweak = { "gui": "#eeeeee"}
      let s:fore = { "gui": "#333333"}
      let s:forestrong = { "gui": "#000000"}
      let s:foreweak = { "gui": "#555555"}
    else
      echoerr "No mode named: " . mode
    endif
  endif
endfunction

function s:GetColors(color_name)
  if a:color_name == "red"   
    return {"color": s:red, "colorprime": s:redprime, "colorfill": s:redfill}
  elseif a:color_name == "pink"   
    return {"color": s:pink, "colorprime": s:pinkprime, "colorfill": s:pinkfill}
  elseif a:color_name == "green"
    return {"color": s:green, "colorprime": s:greenprime, "colorfill": s:greenfill}
  elseif a:color_name == "yellow"
    return {"color": s:yellow, "colorprime": s:yellowprime, "colorfill": s:yellowfill}
  elseif a:color_name == "orange"
    return {"color": s:orange, "colorprime": s:orangeprime, "colorfill": s:orangefill}
  elseif a:color_name == "blue"
    return {"color": s:blue, "colorprime": s:blueprime, "colorfill": s:bluefill}
  elseif a:color_name == "purple"
    return {"color": s:purple, "colorprime": s:purpleprime, "colorfill": s:purplefill}
  elseif a:color_name == "cyan"
    return {"color": s:cyan, "colorprime": s:cyanprime, "colorfill": s:cyanfill}
  else
    echoerr "No color name: " . a:color_name
  endif
endfunction

function g:GetPalette(colorset, alpha, beta, gamma, delta, accent, contrast, flare, mode)
  call s:SetColorset(a:colorset, a:mode)

  let l:palette = {}
  let l:alpha = s:GetColors(a:alpha)
  let l:palette.alpha = l:alpha.color
  let l:palette.alphaprime = l:alpha.colorprime
  let l:palette.alphafill = l:alpha.colorfill

  let l:beta = s:GetColors(a:beta)
  let l:palette.beta = l:beta.color
  let l:palette.betaprime = l:beta.colorprime
  let l:palette.betafill = l:beta.colorfill
  
  let l:beta = s:GetColors(a:beta)
  let l:palette.beta = l:beta.color
  let l:palette.betaprime = l:beta.colorprime
  let l:palette.betafill = l:beta.colorfill
  
  let l:gamma = s:GetColors(a:gamma)
  let l:palette.gamma = l:gamma.color
  let l:palette.gammaprime = l:gamma.colorprime
  let l:palette.gammafill = l:gamma.colorfill
  
  let l:delta = s:GetColors(a:delta)
  let l:palette.delta = l:delta.color
  let l:palette.deltaprime = l:delta.colorprime
  let l:palette.deltafill = l:delta.colorfill
  
  let l:accent = s:GetColors(a:accent)
  let l:palette.accent = l:accent.color
  let l:palette.accentprime = l:accent.colorprime
  let l:palette.accentfill = l:accent.colorfill
  
  let l:contrast = s:GetColors(a:contrast)
  let l:palette.contrast = l:contrast.color
  let l:palette.contrastprime = l:contrast.colorprime
  let l:palette.contrastfill = l:contrast.colorfill
  
  let l:flare = s:GetColors(a:flare)
  let l:palette.flare = l:flare.color
  let l:palette.flareprime = l:flare.colorprime
  let l:palette.flarefill = l:flare.colorfill
  
  let l:palette.aft = s:aft
  let l:palette.aftstrong = s:aftstrong
  let l:palette.aftweak = s:aftweak
  
  let l:palette.fore = s:fore
  let l:palette.forestrong = s:forestrong
  let l:palette.foreweak = s:foreweak
  
  " basic colors
  let l:palette.red = s:red
  let l:palette.redprime = s:redprime
  let l:palette.redfill = s:redfill
  
  let l:palette.pink = s:pink
  let l:palette.pinkprime = s:pinkprime
  let l:palette.pinkfill = s:pinkfill

  let l:palette.green = s:green
  let l:palette.greenprime = s:greenprime
  let l:palette.greenfill = s:greenfill
  
  let l:palette.yellow = s:yellow
  let l:palette.yellowprime = s:yellowprime
  let l:palette.yellowfill = s:yellowfill
  
  let l:palette.orange = s:orange
  let l:palette.orangeprime = s:orangeprime
  let l:palette.orangefill = s:orangefill
  
  let l:palette.blue = s:blue
  let l:palette.blueprime = s:blueprime
  let l:palette.bluefill = s:bluefill
  
  let l:palette.purple = s:purple
  let l:palette.purpleprime = s:purpleprime
  let l:palette.purplefill = s:purplefill
  
  let l:palette.cyan = s:cyan
  let l:palette.cyanprime = s:cyanprime
  let l:palette.cyanfill = s:cyanfill


  return  l:palette
endfunction
