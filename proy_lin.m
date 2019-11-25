%[ecuacion,pendiente,ordenada]=proy_lin(x)
%EJECUCIÓN DEL PROGRAMA
%En el siguiente código encontramos la ecuacion de la recta
%mediante mínimos cuadrados, constituida por la pendiente (m)  y
%la intercepcion en y (b).
%Para encontrar dichos valores se utilizó la siguiente fórmula
%m=(Exy - ((Ex*Ey)/n))/(Ex^2-(((Ex)^2)/n))  E=sumatoria
%b=y'-mx'; donde x' y y' son las medias de las coordenadas x,y

%variables globales para ser reutilizadas en otra funcion
global b=0;
global m=0;
global ecuacion;

%recibe como parametro una matriz de valores en dos dimensiones
function proy_lin(x)
  x1=[]; %vector con valores de x para graficar
  y1=[]; %vector con valores de y para graficar
  xy=0; %variable que almacena la sumatoria de x*y, valor necesario para aplicar el metodo de minimos cuadrados
  %condicion para comprobar que la matriz ingresada tenga dos columnas, la matriz contenga valores y el numero de valores en ambas columnas sea igual
  if(columns(x)==2 && rows(x(:,1))==rows(x(:,2))&& size(x,2)>0) 
    for i=1:rows(x)
      x1(end+1,:)=x(i,1); %agrego valores de x al vector correspondiente
      y1(end+1,:)=x(i,2); %agrego valores de y al vector correspondiente
      xy+=x(i,1)*x(i,2); %multiplico y sumo valores a la variable xy
     endfor 
     global m; 
     m=(xy-(sum(x1)*sum(y1))/rows(x))/(sum(x1.^2)-((sum(x1).^2)/rows(x))); %pendiente calculada con la formula de minimos cuadrados
     %sum(x1) permite hacer la sumatoria de un vector. sum(x1.^2) sumatoria de un vector elevado al cuadrado
     global b;
     b=(sum(y1)/rows(x))-m*(sum(x1)/rows(x)); %valor de ordenada calculada con la formula de minimos cuadrados
     x2=[min(x1)-2:1:max(x1)+2];  %creamos un vector los valores de x con los cuales se graficara la pendiente
     y2=m*x2+b; %y2 vector con valores calculados a partir de los valores de x2
     plot(x1,y1,"*r",x2,y2); %graficamos matriz ingresada y la recta generada
     global ecuacion;
     ecuacion = strcat( " y =  ",num2str(m),"x + (",num2str(b),")" ); %strcat metodo para crear una cadena de texto y adicionar texto
     legend("Matriz x,y",ecuacion);
     xlabel("X");
     ylabel("Y");
     title("Proyección lineal por mínimos cuadrados");
     disp(strcat("Ecuación de la recta --> ",ecuacion)); %texto para mostrar al usuario
     disp(strcat( "Pendiente --> ",num2str ( m )));
     disp(strcat( "Ordenada al origen --> ",num2str ( b )));
     %seguido hacemos evaluamos la ecuacion en un punto ingresado por el usuario -> a
     a = input("\n\nLiteral 5.\nIngrese el valor de a = ");
     eval_proy(a); %llamada a la funcion
  else
      ecuacion = "Parámetro de entrada incorrecto!";
  endif
endfunction

function eval_proy(a)
  global m;
  global b;
  global ecuacion;
  h=m*a+b; %h es r=el resultado de evaluar el valor a el la ecuacion donde m=pendiente, b=ordenada fueron calculados en la funcion anterior y a=x
  printf("\nFuncion proyectada %s en valor a= %.3f ",ecuacion,a);
  printf("\nValor Final y= %.3f\n",h);
endfunction