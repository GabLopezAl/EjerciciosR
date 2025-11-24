
R version 4.3.2 (2023-10-31 ucrt) -- "Eye Holes"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R es un software libre y viene sin GARANTIA ALGUNA.
Usted puede redistribuirlo bajo ciertas circunstancias.
Escriba 'license()' o 'licence()' para detalles de distribucion.

R es un proyecto colaborativo con muchos contribuyentes.
Escriba 'contributors()' para obtener más información y
'citation()' para saber cómo citar R o paquetes de R en publicaciones.

Escriba 'demo()' para demostraciones, 'help()' para el sistema on-line de ayuda,
o 'help.start()' para abrir el sistema de ayuda HTML con su navegador.
Escriba 'q()' para salir de R.

[Previously saved workspace restored]

> getwd()
[1] "C:/Users/DELL/Documents"
> load("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\EjerciciosR\\EjemploRegresionLineal\\.RData")
> View(insurance)
> summary(ins_model)

Call:
lm(formula = expenses ~ ., data = insurance)

Residuals:
   Min     1Q Median     3Q    Max 
 -6707  -1989  -1492  -1057 231252 

Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
(Intercept)         -1.155e+03  3.514e+02  -3.287  0.00101 ** 
age                 -1.886e+00  3.145e+00  -0.600  0.54866    
geo_areasuburban     1.911e+02  1.432e+02   1.334  0.18210    
geo_areaurban        1.691e+02  1.579e+02   1.071  0.28402    
vehicle_typeminivan  1.153e+02  2.766e+02   0.417  0.67683    
vehicle_typesuv     -1.970e+01  1.180e+02  -0.167  0.86743    
vehicle_typetruck    2.157e+01  1.536e+02   0.140  0.88835    
est_value            3.114e-02  2.497e-03  12.475  < 2e-16 ***
miles_driven         1.190e-01  1.433e-02   8.305  < 2e-16 ***
college_grad_ind    -2.504e+01  1.156e+02  -0.217  0.82848    
speeding_ticket_ind  1.558e+02  1.402e+02   1.112  0.26624    
hard_braking_ind     1.185e+01  1.069e+02   0.111  0.91178    
late_driving_ind     3.625e+02  2.247e+02   1.614  0.10665    
clean_driving_ind   -2.390e+02  1.111e+02  -2.152  0.03140 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6995 on 19986 degrees of freedom
Multiple R-squared:  0.01241,   Adjusted R-squared:  0.01176 
F-statistic: 19.31 on 13 and 19986 DF,  p-value: < 2.2e-16

> insurance$age2 <- insurance$age^2
> ins_model2 <- lm(expenses ~ . + hard_braking_ind:late_driving_ind,
+ data = insurance)
> summary(ins_model2)

Call:
lm(formula = expenses ~ . + hard_braking_ind:late_driving_ind, 
    data = insurance)

Residuals:
   Min     1Q Median     3Q    Max 
 -6618  -1996  -1491  -1044 231358 

Coefficients:
                                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)                       -5.350e+02  4.571e+02  -1.170   0.2419    
age                               -3.314e+01  1.537e+01  -2.157   0.0310 *  
geo_areasuburban                   1.788e+02  1.433e+02   1.248   0.2121    
geo_areaurban                      1.325e+02  1.587e+02   0.835   0.4040    
vehicle_typeminivan                1.717e+02  2.779e+02   0.618   0.5367    
vehicle_typesuv                   -8.006e+00  1.181e+02  -0.068   0.9460    
vehicle_typetruck                  2.643e+01  1.537e+02   0.172   0.8634    
est_value                          3.118e-02  2.496e-03  12.489   <2e-16 ***
miles_driven                       1.187e-01  1.433e-02   8.289   <2e-16 ***
college_grad_ind                   1.725e+01  1.174e+02   0.147   0.8832    
speeding_ticket_ind                1.551e+02  1.401e+02   1.107   0.2685    
hard_braking_ind                  -1.244e+01  1.098e+02  -0.113   0.9098    
late_driving_ind                   1.833e+02  2.842e+02   0.645   0.5189    
clean_driving_ind                 -2.328e+02  1.111e+02  -2.096   0.0361 *  
age2                               3.432e-01  1.653e-01   2.076   0.0380 *  
hard_braking_ind:late_driving_ind  4.691e+02  4.617e+02   1.016   0.3096    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6995 on 19984 degrees of freedom
Multiple R-squared:  0.01267,   Adjusted R-squared:  0.01193 
F-statistic:  17.1 on 15 and 19984 DF,  p-value: < 2.2e-16

> insurance$pred <- predict(ins_model2, insurance)
> cor(insurance$pred, insurance$expenses)
[1] 0.1125714
> plot(insurance$pred, insurance$expenses)
> abline(a = 0, b = 1, col = "red", lwd = 3, lty = 2)
> Predecir los gastos de un nuevo seguro
Error: unexpected symbol en "Predecir los"
> # Predecir los gastos de un nuevo seguro
> predict(ins_model2,
+ data.frame(age = 30, age2 = 30^2, geo_area = "rural",
+ vehicle_type = "truck", est_value = 25000,
+ miles_driven = 14000, college_grad_ind = 0,
+ speeding_ticket_ind = 0, hard_braking_ind = 0,
+ late_driving_ind = 0, clean_driving_ind = 1))
       1 
1015.059 
> predict(ins_model2,
+ data.frame(age = 30, age2 = 30^2, geo_area = "rural",
+ vehicle_type = "truck", est_value = 25000,
+ miles_driven = 14000, college_grad_ind = 0,
+ speeding_ticket_ind = 0, hard_braking_ind = 0,
+ late_driving_ind = 0, clean_driving_ind = 0))
       1 
1247.903 
> # Usar el coeficiente de regresión del modelo de 0.118748 para millas recorridas
> predict(ins_model2,
+ data.frame(age = 30, age2 = 30^2, geo_area = "rural",
+ vehicle_type = "truck", est_value = 25000,
+ miles_driven = 14000, college_grad_ind = 0,
+ speeding_ticket_ind = 0, hard_braking_ind = 0,
+ late_driving_ind = 0, clean_driving_ind = 0))
       1 
1247.903 
> 2435.384 - 1247.903
[1] 1187.481
> save.image("C:\\Users\\DELL\\Documents\\SERVICIO_SOCIAL\\EjemplosEjercicios\\EjerciciosR\\EjemploRegresionLineal\\Regresion Final")
> 
