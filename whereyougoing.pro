pro whereyougoing

readcol, 'Hyades.txt', star, ra, dec, parallax, promora, promodec, v , bmv, rv
xran = 200

plot, ra, dec, psym=2, yrange = [-75,100], xrange = [30,200],$
   xtitle = 'Right Ascension' , ytitle = 'Declination'
;draw a line through each star that shows its proper motion
; y and y1, dec and ra
; y - y1 = m (x - x1)

yarr = findgen(120) ;these loops are to calculate the arrays to plot the graphs
for i = 0,119 do begin
  x = [ra[i], xran]
  m = promodec / promora
  y = m[i] * (x - ra[i]) + dec[i]
  yarr[i] = y[1]
  oplot, x,y
endfor
;plot, bmv, v, psym=3, yrange = [12,2]     
intdec = findgen(7140)
intra = findgen(7140)
count = 0
for i = 0, 119 do begin ; each vector lenght is calculated with this nested for loop
  for j = i + 1, 119 do begin; utalizing the lint program
      a = [ra[i],dec[i]]
      b = [xran, yarr[i]]  
      ;[ra[i] + 1, m[i] * (x - ra[i]) + dec[i]]
      c = [ra[j],dec[j]]
      d = [xran, yarr[j]] 
      ;[ra[j] + 1, m[j] * (x - ra[j]) + dec[j]]
     
      lint, a, b, c, d,intsec
      intra[count] = intsec[0]
      intdec[count] = intsec[1]
      count = count + 1
    endfor  
endfor
print, median(intdec) ;here are the calculations used to find the variables and the final distance 
print, median(intra) ; to the hydes cluster using both parallax and the combined formula
oplot, intra, intdec, psym=5
print, "mean RA" , mean(ra)
print, "mean Dec", mean(dec)
print, "magnitude of proper motion vector mu" , (sqrt(mean(promora)^2 + mean(promodec)^2))/100
lam = abs((mean(ra) - median(intra)))* !pi/180
print, "lam ", lam
vr = median(rv)
print, "vr" , vr
mu = (sqrt(mean(promora)^2 + mean(promodec)^2))/100
print, "mu: ", mu
print, "proper motion d = ", (vr * tan(lam))/(4.74 * mu) 
print, "paralax distance"
pd = 1/mean(parallax)
print, pd
end

 
