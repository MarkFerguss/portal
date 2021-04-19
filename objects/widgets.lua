function setWindows()
    bg = f.addWin(m,1,1,w,h) bg.reset = {bg_color="black"}
    list = f.addWin(m,1,2,w*3/5-1,chestSize) list.reset = {bg_color="black"}
    up_bar = f.addWin(m,1,1,w,1) up_bar.reset = {bg_color="lightGray",printText = function()
        f.centerText(up_bar,1,"selectionner une destination","black","lightGray") end}
    down_bar = f.addWin(m,1,h,w,h) down_bar.reset = {bg_color="lightGray",printText = function()
        f.centerTextRight(down_bar,1,"v"..version,"black","lightGray") end}
    scroll_bar = f.addWin(m,w*(3/5),2,1,h-1) scroll_bar.reset = {bg_color="lightGray",printText = function()
        f.cprint(scroll_bar,1,1,"^","black","gray")
        f.cprint(scroll_bar,1,h-2,"v","black","gray") end}
    bg2 = f.addWin(m,w*0.6+1,2,w*0.4+1,h-1) bg2.reset = {bg_color="gray",printText = function()
        f.cprint(bg2,2,1,"Status: ","white","gray")
        f.cprint(bg2,2,7,"Rechercher:","white","gray")
        f.drawLine(bg2,2,9,bg2.size[1]-2.4,"lightGray")
        f.cprint(bg2,2,11,"Taper dans le","white","gray")
        f.cprint(bg2,2,12," computer une ","white","gray")
        f.cprint(bg2,2,13," recherche.","white","gray")
        f.cprint(bg2,2,14,"Double-cliquer sur","white","gray")
        f.cprint(bg2,2,15," un nom pour se","white","gray")
        f.cprint(bg2,2,16," teleporter.","white","gray") end}
    b1 = f.addWin(bg2,2,3,bg2.size[1]-2,3) b1.reset = {bg_color="red",printText = function()
        f.centerText(b1,2,"fermer","black","red") end}
    b2 = f.addWin(bg2,2,18,bg2.size[1]-2,3) b2.reset = {bg_color="red",printText = function()
        f.centerText(b2,2,"quitter le module","black","red") end}
    b3 = f.addWin(bg2,bg2.size[1]-1,9,1,1) b3.reset = {bg_color="white",printText = function()
        f.cprint(b3,1,1,"x","lightGray","white") end}
end
