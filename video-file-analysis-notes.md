## Container

Example

mov,mp4,m4a,3gp,3g2,mj2

or

matroska,webm

A container is the wrapper that holds everything.

Think of it as a cardboard box.

Inside the box are

video
audio
subtitles
chapters
metadata

The container itself is not the video.


## Video Codec

Example

h264

or

hevc

The codec is the algorithm that compresses the video.

Imagine taking a 400 GB movie and shrinking it to 4 GB.

That's the codec.

Common codecs

MPEG2
H264
HEVC (H265)
AV1


## Codec Profile

Example

High

or

Main 10

A codec has different "levels of complexity."

Like difficulty settings in a game.

For H264

Baseline
Main
High

For HEVC

Main
Main 10
Main Still Picture

Older TVs often cannot decode newer profiles.

This is why this field matters.


## Pixel Format

Example

yuv420p

or

yuv420p10le

This tells us how colour information is stored.

For example

yuv420p

means

Y = brightness
U/V = colour

420 means colour is stored at lower resolution to save space.

The

10

means

10 bits per colour sample.

That usually gives smoother gradients.


## Resolution

Example

1920 x 1080

Simply

width × height

Number of pixels.


## Aspect Ratio

Example

16:9

or

160:67

This describes the picture shape.

Not the resolution.

Example

1920×1080

1280×720

Both are

16:9


## Scan Type

Example

progressive

or

unknown

Old televisions drew

odd lines

then

even lines

This is

Interlaced

Modern displays use

progressive

Meaning every frame contains every line.

Progressive is preferred today.


## Frame Rate

Example

23.98 fps

How many pictures are shown every second.

Common values

23.976

24

25

29.97

30

50

60

Higher frame rate

↓

smoother motion


## Audio Codec

Examples

AAC

AC3

EAC3

MP3

FLAC

Exactly like the video codec.

Compression for audio.


## Audio Channels

Example

2

means

Stereo

6

means

5.1 surround

8

means

7.1 surround


## Audio Sample Rate

Example

48000

means

48 kHz

How many audio samples are taken each second.

Common

44100

48000

96000


## Subtitle Codec

Example

subrip

means

SRT subtitles

Other examples

mov_text

ass

dvd_subtitle


## Bitrate

Example

4.15 Mbps

Average amount of data used every second.

Higher bitrate

usually

↓

better quality

↓

larger file

although codec efficiency also matters.


## Duration

How long the movie is.

Example

02:17:03


## Size

Actual file size.

Example

4645 MB
