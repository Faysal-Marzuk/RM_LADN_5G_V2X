function In=calcIn(alpha,R,Pt)
%calculate mean interference power for uniformly
%distributed terminals and regular hexagonal net with cell size of R.
%R- expressed in km
%beta assumed to be 1
%alpha attenuation factor (calculated form COST-321 Hata) terminal heigth
%approx 1.5 m base height approx 30m freq 2GHz

fun=@(x,y)(x.^(alpha+1.0))./(sqrt(x.^2+4.0 + 4.0.*x.*cos(y)).^(alpha));
In=integral2(fun,0,1,0,2*pi);
In=In*Pt*(R.^-(alpha+1))/pi;
end