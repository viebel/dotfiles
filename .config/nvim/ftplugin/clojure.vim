:omap <buffer> e <m-e>
:omap <buffer> w <m-w>
" Duplicate a form
:nmap <buffer> <M-p> yafP`]l<C-j>
":setlocal foldmethod=indent
" Comment out the current form
:nmap <buffer> <leader>cc m"(i#_<ESC>`"2l
" Comment out the current top level form
:nmap <buffer> <leader>cC m"[[i#_<ESC>`"2l
" Uncomment the closest commented form
" Explanation:
" Do not alter the search buffer
" Look for multiple occurrences of `#_` (\v for Regex pattern)
" Delete the search match
" Move back to original location
:nmap <buffer> <leader>cu m"<Cmd>let s=@/<CR>l?\v(#_)+<CR>dgn:let @/=s<CR>`"2h
