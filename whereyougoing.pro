pro whereyougoing

readcol, 'Hyades.txt', star, ra, dec, parallax, promora, promodec, v , bmv, rv

plot, ra, dec, psym=2, yrange = [-75,100], xrange = [30,200]
;draw a line through each star that shows its proper motion
; y and y1, dec and ra
; y - y1 = m (x - x1)
x = [0, 200]
m = findgen(120)
for i = 0,119 do begin
  m[i] = (promodec[i] / promora[i])
  y = m[i] * (x - ra[i]) + dec[i]
  oplot, x,y
endfor
;plot, bmv, v, psym=3, yrange = [12,2]     
end

