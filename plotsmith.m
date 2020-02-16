%% Copyright (c) 2020, viralgecko
%% All rights reserved.
%%
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions are met:
%%
%% 1. Redistributions of source code must retain the above copyright notice, this
%%    list of conditions and the following disclaimer.
%%
%% 2. Redistributions in binary form must reproduce the above copyright notice,
%%    this list of conditions and the following disclaimer in the documentation
%%    and/or other materials provided with the distribution.
%%
%% 3. Neither the name of the copyright holder nor the names of its
%%    contributors may be used to endorse or promote products derived from
%%    this software without specific prior written permission.
%%
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
%% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
%% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
%% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
%% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
%% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function [] = plotsmith(frequency,z)
  sz = size(z);
  sf = size(frequency);
  if size(z) != size(frequency)
    error('The Impedance vector must be of same size as the Frequency vector');
  end
  
  if ((sz(1)!=1) && (sz(2)!=1))
    error('The Impedance must be a Vector');
  end
  if sz(1)!=1
    z=z.';
  endif
  if sf(1)!=1
    frequency=frequency.';
  endif
  num_points=801;
  real_axis_x=linspace(-1,1,num_points);
  real_axis_y=zeros(1,num_points);
  circle=linspace(0,2*pi,num_points);
  circle_x=cos(circle);
  circle_y=sin(circle);
  figure;
  title('Z_W=50\Omega SmithChart');
  hold on;
  plot(real_axis_x,real_axis_y,'k');
  set(gca,'visible','off');
  plot(circle_x,circle_y,'k');
  one=ones(1,num_points);
  for n=[0.2 0.5 1 2 5]
    im=1i*n;
    ret=(n-1)/(n+1);
    imt=(im-1)/(im+1);
    a=real(imt);
    b=imag(imt);
    rim=1/n;
    rre=(1-ret)/2;
    cosp=((a-1)/rim);
    sinp=((b/rim)-1);
    phi=atan2(sinp,cosp);
    if ( phi < 0)
      start=phi+(2*pi);
    else
      start=phi;
    end
    part=linspace(start,3*(pi/2),801);
    circ_r_x=(rre.*cos(circle))+(one-(rre.*one));
    circ_r_y=(rre.*sin(circle));
    plot(circ_r_x,circ_r_y,'k--');
    circ_i_x=(rim.*cos(part))+one;
    circ_i_y=(rim.*sin(part))+(one.*rim);
    plot(circ_i_x,circ_i_y,'k-.');
    plot(circ_i_x,-circ_i_y,'k-.');
  endfor
  zn=z./50;
  zt=(zn-1)./(zn+1);
  plot(real(zt),imag(zt),'r');
endfunction
