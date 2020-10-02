gst-launch-1.0  -e pulsesrc device=alsa_input.usb-XMOS_XMOS_Microphone_Array_UAC2.0-00.multichannel-input \
! queue \
! audioresample ! audioconvert \
! audio/x-raw,rate=22050,channels=1 ! wavenc name=enc \
! filesink location=test.wav
