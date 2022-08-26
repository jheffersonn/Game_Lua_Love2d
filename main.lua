--variaveis-------------------------------------------------------------------
alturaTela= 480
larguraTela = 320
maxMeteoro = 5
--FIM_JOGO = false
TIME_JOG0 = 0
fase=500
fase_jogo = 0
--pausa = false
comandos="[P]Pausar [0]Fechar"
--variavel--------------------------------------------------------------------




--array-e-table------------------------------------------------------------------
meteoros = {}
aviao_14bis = {
    src="image/14bis.png",
    largura=55,
    altura=61,
    x = larguraTela/2-64/2,
    y = alturaTela - 80
  }
  
  
--array-e-table-------------------------------------------------------------------

--funcoes--------------------------------------------------------------------------
function destroiAviao()
  aviao_14bis.src = "image/explosao_nave.png"
  aviao_14bis.image = love.graphics.newImage(aviao_14bis.src)
  aviao_14bis.largura= 45
  aviao_14bis.altura= 53
  end
  
function temColisao(X1, Y1, L1, A1, X2, Y2, L2, A2)
  return  X2 < X1 + L1 and
          X1 < X2 + L2 and
          Y1 < Y2 + A2 and
          Y2 < Y1 + A1
  end
  
function removeMeteoros()

   for i = #meteoros, 1, -1 do
  
  if meteoros[i].y > alturaTela then
    table.remove(meteoros,i)
  end
end

   
   end

function criaMeteoro()
    
    meteoro= {
      x=math.random(larguraTela),
      y=-70,
      largura=48,
      altura=33,
      peso = math.random(2),
      deslocamentoH = math.random(-1,1)
      }
    table.insert(meteoros, meteoro)
  end
  
function moveMeteoro()
  
    for k,meteoro in pairs(meteoros) do
      meteoro.y = meteoro.y + meteoro.peso
      meteoro.x = meteoro.x + meteoro.deslocamentoH
    end        
end


  
function move14bis()
       
  if love.keyboard.isDown("w") then
    aviao_14bis.y = aviao_14bis.y-1
  end
  
  if love.keyboard.isDown("s") then
    aviao_14bis.y = aviao_14bis.y+1
  end
  
  if love.keyboard.isDown("a") then
    aviao_14bis.x = aviao_14bis.x-1
  end
  
  if love.keyboard.isDown("d") then
    aviao_14bis.x = aviao_14bis.x+1
  end
  
end
function checaColisoes()
  
    for k, meteoro in pairs(meteoros) do
      if temColisao(meteoro.x, meteoro.y, meteoro.largura, meteoro.altura, aviao_14bis.x, aviao_14bis.y, aviao_14bis.largura, aviao_14bis.altura) then 
      destroiAviao()
      FIM_JOGO=true
      comandos= "[R]Reiniciar [0]Fechar"
    end
  end
end





--funcoes-----------------------------------------------------------------------

--core-love----------------------------------------------------------------------------------
function love.load()
  math.randomseed(os.time())
  love.window.setMode(larguraTela,alturaTela,{resizable = false})
  love.window.setTitle("14bis vs Meteoros ")
  backgound = love.graphics.newImage("image/background.png")
  meteoro_img = love.graphics.newImage("image/meteoro.png")
  aviao_14bis.image = love.graphics.newImage(aviao_14bis.src)

end




function love.update(dt)
  if love.keyboard.isDown ("0") then
    love.event.quit()
  end
  
  if love.keyboard.isDown ("p") then
        pausa = not pausa 
          
          if not FIM_JOGO then
            comandos= "[P]Voltar"
          end
      end
  
  if not FIM_JOGO and  not pausa then 
    comandos= "[P]Pausar [0]Fechar"
    love.graphics.print(comandos, larguraTela/2/2, alturaTela-15)
    
    removeMeteoros()

    if #meteoros < maxMeteoro then

      criaMeteoro()   
  end

      moveMeteoro()
    if love.keyboard.isDown("a","s","d","w") then
    move14bis()
  end
  

  TIME_JOG0 = TIME_JOG0 +1
   
   if TIME_JOG0 > fase then
     
     fase = fase + 500
     maxMeteoro = maxMeteoro +1
     fase_jogo = fase_jogo+1
     end
  -- t = love.timer.getMicroTime(1)


    checaColisoes()

  end

end



function love.draw()
   
    love.graphics.draw(backgound,0,0)
    --love.graphics.setColor(0, 0.4, 0.4)
    
  for k, meteoro in pairs(meteoros) do
      
      love.graphics.draw(meteoro_img,meteoro.x,meteoro.y)
      
  end
  
    love.graphics.draw(aviao_14bis.image,aviao_14bis.x,aviao_14bis.y)
    love.graphics.print("Nível:"..fase_jogo, 250, 20)
    love.graphics.print(comandos, larguraTela/2/2, alturaTela-15)
    --love.graphics.print(t , 200, 10)
    
    --meteoro
    
end
--core--love----------------------------------------------------------------------------------