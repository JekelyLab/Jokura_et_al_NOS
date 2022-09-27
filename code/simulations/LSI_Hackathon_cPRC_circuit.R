cPRC_NO_model <- function (t, x, params) {
  ## first extract the state variables
  cPRC <- x[1]
  UV <- x[2]
  cGMP <- x[3]
  S <- x[4]
  NOS <- x[5]
  NO <- x[6]
  ## now extract the parameters
  delta_cPRC <- params["delta_cPRC"]
  alpha_cPRC <- params["alpha_cPRC"]
  k_UV_cPRC <- params["k_UV_cPRC"]
  k_G_cPRC <- params["k_G_cPRC"]
  k_UV_G_PRC <- params["k_UV_G_PRC"]
  NIT <- params["NIT"]
  alpha_G_PRC <- params["alpha_G_PRC"]
  delta_G_PRC <- params["delta_G_PRC"]
  k_N_PRC <- params["k_N_PRC"]
  tau_S <- params["tau_S"]
  delta_C_NOS <- params["delta_C_NOS"]
  alpha_C_NOS <- params["alpha_C_NOS"]
  tau_N <- params["tau_N"]
  delta_N_NOS <- params["delta_N_NOS"]
  alpha_N_NOS <- params["alpha_N_NOS"]
  ## now code the model equations
  dcPRCdt <- k_UV_cPRC*UV + k_G_cPRC*cGMP - delta_cPRC*cPRC + alpha_cPRC
  dcGMPdt <- alpha_G_PRC + k_N_PRC*NO - delta_G_PRC*cGMP - k_UV_G_PRC*UV*cGMP*NIT

  dSdt = (UV*NIT - S)/tau_S
  dNOSdt = S - delta_C_NOS*NOS + alpha_C_NOS
  dNOdt = (NOS - delta_N_NOS*NO + alpha_N_NOS)/tau_N
  ## combine results into a single vector
  dxdt <- c(dcPRCdt, UV, dcGMPdt, dSdt, dNOSdt, dNOdt)
  ## return result as a list!
  list(dxdt)
}

{
parms <- c(
  delta_cPRC = 1,
  alpha_cPRC = 1,
  k_UV_cPRC = 1,
  k_G_cPRC = 5,
  k_UV_G_PRC = 0.5,
  NIT = 1,
  alpha_G_PRC = 0.01,
  delta_G_PRC = 0.02,
  k_N_PRC = 0.03,
  tau_S = 1,
  delta_C_NOS = 1,
  alpha_C_NOS = 0,
  delta_N_NOS = 1,
  alpha_N_NOS = 0,
  tau_N = 10
)

times <- seq(from=0, to=250, by=1)

xstart <- c(
  cPRC = runif(1), 
  UV=0,
  cGMP = runif(1), 
  S = runif(1), 
  NOS = runif(1), 
  NO = runif(1)
)

eventdat <- data.frame(var = c(rep("UV", 250) ),
                       time = c(1:250) ,
                       value = c(rep(0,190), rep(1,20), rep(0,40)),
                       method = c("replace"))

ode(
  func=cPRC_NO_model,
  y=xstart,
  times=times,
  parms=parms,
  method = "ode45",
  events = list(data = eventdat)
) %>%
  as.data.frame() -> out


out %>%
  gather(variable,value,-time) %>%
  ggplot(aes(x=time,y=value,color=variable))+
  geom_line(size=1)+
  theme_classic()+
  labs(x='time (sec)',y='activity')+
  scale_x_continuous(limits = c(150,250))
#+
#  facet_wrap(vars(variable))

}

k_N_PRCvals <- c(0.01, 0.2)
k_N_PRCvals[1]


for(i in 1:2) {
  parms["k_N_PRCvals"] <- k_N_PRCvals[i]
  ode(
    func=cPRC_NO_model,
    y=xstart,
    times=times,
    parms=parms,
    method = "ode45",
    events = list(data = eventdat)
  ) %>%
    as.data.frame() -> out
  
  
  out %>%
    gather(variable,value,-time) %>%
    ggplot(aes(x=time,y=value,color=variable))+
    geom_line(size=1)+
    theme_classic()+
    labs(x='time (sec)',y='activity')+
    scale_x_continuous(limits = c(150,250))
}
  

#screen parameters

k_N_PRCvals <- c(0.01, 0.02)

expand.grid(k_N_PRC = k_N_PRCvals) %>%
  do(
    {
      ode(
        func=cPRC_NO_model,
        y=xstart,
        times=times,
        parms=c(k_N_PRC = .$k_N_PRC),
        method = "ode45",
        events = list(data = eventdat)
      ) 
    }
  ) %>%
  gather(variable,value,-time) %>%
  ggplot(aes(x=time,y=value,color=variable))+
  geom_line(size=1)+
  theme_classic()+
  labs(x='time (sec)',y='activity')+
  scale_x_continuous(limits = c(150,250))

facet_grid(beta~gamma,scales='free_y',labeller=label_both)+
  