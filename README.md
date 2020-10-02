# Audio Streamig 

## **Content**
* [To Record and Playback](#to-record-and-playback)
* [To send message to another ubuntu PC using ethernet crossover cable](#to-send-message-to-another-ubuntu-pc-using-ethernet-crossover-cable)
* [trx: Realtime audio over IP](#trx-realtime-audio-over-ip)
* [Beamform](#beamform)

## To Record and Playback

**Steps:**

To Record: ` arecord -D hw:0,0,0 -f S16_LE -c 2 -r 48000 recorded.wav` and To Play: `aplay recorded.wav`

**For XMOS Microphone array:**
* run ./[xmos_recorder.sh](./xmos_recorder.sh)  It uses Gstreamer

**Reference:**
* [Raspberry Pi Wiring & Test](https://learn.adafruit.com/adafruit-i2s-mems-microphone-breakout/raspberry-pi-wiring-and-test)
* [Playing with ALSA loopback devices](https://sysplay.in/blog/tag/arecord/)

**Note:**
* Do this in order to check the quality of the hardware.

## To send message to another ubuntu PC using ethernet crossover cable

**Steps:**
* Connect both the PC by ethernet crossover cable.
* Go to wired network setting -> IPv4 ->  select Link-Local Only in both the PC.
* Find your the local ip address by `hostname -I` , say for PC1: `169.254.21.232` and PC2: `169.254.31.155`
* You can test the connection by `ping <ip-addrress-of-other-PC>`
* On the receiving computer do `nc -l 3333`
* On the sending computer do `nc <ip-addrress-of-receiving-PC> 3333`
* Then just start typing and the text will show up on the other computer (after you press enter) until you hit ctlr+c. 

**Troubleshoots**
* If you are able to ping. But, still not able to send and receive messages then your firewall might be blocking: [Do answer 2](https://superuser.com/questions/560969/ncat-only-works-in-certain-scenarios/561848)

## trx: Realtime audio over IP

**Steps:**
 * Download `wget www.pogo.org.uk/~mark/trx/releases/trx-0.3.tar.gz` and Unzip it`tar xvf trx-0.3.tar.gz`
 * Make sure you have the dependencies or else install it by: `sudo apt install libortp-dev libopus0 libopus-dev libasound2-dev alsa alsa-tools`
 * `cd trx-0.3` and `sudo make` to build and `sudo make install` to install the binaries
 *  To send audio from default soundcard to the given host: `sudo tx -h 169.254.88.116` and to receive audio and play it: `rx`
 *  For sending audio from a specific device to specific port: `sudo tx -h 10.255.43.100 -d plughw:2,0 -p 5555` & `sudo rx -h 10.255.43.100 -p 5555`  the ip address is the address of the client.
 *  To receive it using ffmpeg: `ffplay rtp://169.254.88.116:1350 -acodec opus` (**ffmpeg has cross platform support**)

**Reference:**
* [Official page](http://www.pogo.org.uk/%7Emark/trx/)

**Note:**
* **Works well...! :smiley:**

**Troubleshoots**
* sched_setscheduler: Operation not permitted: [1](https://forums.developer.nvidia.com/t/operation-not-permitted-by-using-sched-setscheduler/70114)
* Home directory not accessible: Permission denied: (sudo su) But, other solutions?
* `pulseaudio --start` to start pulseaudio. Ref [1](https://askubuntu.com/questions/15223/how-can-i-restart-pulseaudio-without-having-to-logout)

## Beamform 

**For ODAS &  [XMOS Microphone array](https://www.xmos.com/products/voice/micarray)**

1. Install odas, follow the steps [here](https://github.com/introlab/odas/wiki/installation).
2. Then [install odas web](https://github.com/introlab/odas_web)
3. Go to odas web directory and run `npm start`
4. In another terminal, go to `/odas/bin` and then make sure to have [this config file.](./myConfigFile_OK.cfg)
5. Find out the card and device number for the mic by `arecord -l` and enter those values in the config file.
6. Now, run `./odaslive -c myConfigFile_OK.cfg -v`

For Sound Source Localization (ssl), Sound Source Tracking (sst) and  Sound Source Separation (sss) modify the [various parameters](https://github.com/introlab/odas/wiki/configuration).

You will get two audio files, nameley, `postfiltered.raw` and `separated.raw` . Open these file in [audacity](https://www.audacityteam.org/) --> files --> import --> raw amd select th following settings:

![](./settings.png)

**References for listening in a specific direction (Beamforming):**

1. [Beamforming in PulseAudio](https://arunraghavan.net/2016/06/beamforming-in-pulseaudio/)
2. [HARK](https://www.hark.jp/)
3. [Best Pulseaudio Mic Settings](https://github.com/BeanGreen247/BestPulseaudioMicSettings)
4. [PulseAudio under the hood](https://gavv.github.io/articles/pulseaudio-under-the-hood/)
5. [acoustic beamforming tool](https://github.com/xanguera/BeamformIt)
6. [Acoular – Acoustic testing and source mapping software](http://www.acoular.org/)
7. [Microphone Array Beamforming](http://www.labbookpages.co.uk/audio/beamforming.html)
8. [Binaural sound source localization - Software](http://www.laurentcalmes.lu/soundloc_software.html)


**GithUb Beamforming:**
1. [Beamforming Toolkit](https://github.com/robin1001/beamforming)
2. [Pyroomacoustics](https://github.com/LCAV/pyroomacoustics)
3. [Delay Sum Algorithim for Beamforming microphone array of eight Fixed Beamformer Manually select sound location](https://github.com/kreiley/Beamforming)
4. [Beamforming-for-speech-enhancement](https://github.com/AkojimaSLP/Beamforming-for-speech-enhancement)
5. [beamforming noise cancellation](https://github.com/yfang1644/beamforming)
6. [BEAMFORMING Algorithm](https://github.com/pavolusa/beamforming)
7. [ROS package that carries out simple 1D beamforming strategie](https://github.com/balkce/beamform)
8. [DistributedBeamforming](https://github.com/kunalsankhe/DistributedBeamforming)
9. [MCARRAY is a library for real-time digital signal processing of microphone array signals.](https://github.com/jordi-adell/mcarray)
10. [implementing beamforming algorithm for simulation](https://github.com/5yearsKim/beamforming)
11. [Multiple DOA estimation & delay-and-sum beamforming](https://github.com/lmiguelgato/DAP_project)
12. [a simple sample to illustrate circular microphone array separator and recording.](https://github.com/ishine/cmas-sample)
13. [ DSP for beamforming and other applications with C++, using Armadillo and C++. ](https://github.com/UKY-Distributed-Audio-Lab/Toolbox-OOP)


**To Do**

* To listen in a specific direction.
* adding an equalizer at the VR end for the operator to listen to specific frequencies.
* Explore with yonas and dario on how to stream the data. ( with ros? or compression)
* check libraries other than odas for sss.


**To listen in a specific direction**

* [To record in a specific direction](https://github.com/introlab/odas/issues/158)
* [I get only the activity of energy in a particular direction but I want to listen to the audio in that direction. ](https://github.com/introlab/odas/issues/187)
* [To change the directions in real-time use injector moudle (sockets update the direction), but it is not yet implemented.](https://github.com/introlab/odas/issues/14)


**What to do?**

1. Directions are set at `/odas/demo/odaslive/parameters.c 815`. 
2. Need to update them via sockets during run-time.
3. Right now, ODAS sends other data such DoA as a client.
4. So should modify the code on ODAS to get the target directions from server.


ODAS github issues which are useful:
* [Can I record the sound only in fixed direction?](https://github.com/introlab/odas/issues/158)
* [Potential Sorces Energy Range](https://github.com/introlab/odas/issues/28)
* [Beamforming Vector application ](https://github.com/introlab/odas/issues/172)
* [beamforming range advice](https://github.com/introlab/odas/issues/14)
* [increase the gain](https://github.com/introlab/odas/issues/58)
* [Correlate the source with the separation channel](https://github.com/introlab/odas/issues/79)
* [Question regarding SSS](https://github.com/introlab/odas/issues/73)
* [result too bad](https://github.com/introlab/odas/issues/156)
* [Some question about mode of sss](https://github.com/introlab/odas/issues/70)
* [some question about related article.<Enhanced Robot Audition Based on Microphone Array Source Separation with Post-Filter>](https://github.com/introlab/odas/issues/59)
* [Changing the value of samplerate.mu.](https://github.com/introlab/odas/issues/45)
* [Various configuration questions](https://github.com/introlab/odas/issues/15)


References for SSS:

* [Untwist is python library for audio source separation.](https://github.com/IoSR-Surrey/untwist)
* [5_years_old_Class project aimed at using ICA to implement Blind Source Separation on sound signals](https://github.com/joeliven/blind_source_separation_ica)
* [a_template_no_detailed_instruc_Two-Step Sound Source Separation: Training on Learned Latent Targets](https://github.com/etzinis/two_step_mask_learning)
* [in_matlab_robotaudition_examples](https://github.com/balkce/robotaudition_examples)
* [16_gb_ram_Source Separation on Musical Instrument Sounds](https://github.com/rgcda/Musisep)
* [need_to_look_Repository for my dissertation project on "Techniques for Separation of Harmonic Sound Sources" ](https://github.com/willsimmons1465/SoundSeparation)
* [need_to _look_Single Channel Audio Source Separation using Convolutional Denoising Autoencoders](https://github.com/SahilJindal1/Sound-Separation)
* [need_to_look_further_Sound source separation using Probabilistic Latent Component Analysis and Deep Learning.](https://github.com/Singh-Aaditya/UGP)
* [seems_good:Process sound files using Non-negative Matrix Factorization and suffling the resulting matrices.](https://github.com/g-roma/NMFRandomiz)
* [matlab_Blind source separation of linear mixture of sound signals using fast Independent Component Analysis and Singular Value Decomposition.](https://github.com/jaindeepali/cocktail_party)

