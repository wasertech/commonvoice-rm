# Working group for the voice recognition of Romansh (CommonVoice-rm)

## Contents

- [Intro](#intro)
- [Channels](#channels)
- [Participate in CommonVoice-rm](#Participer-à-STT)
- [Process for CommonVoice-rm](#Process-for-CommonVoice-rm)
- [Starting well](#starting well)
  - [Installation and configuration](#Installation-and-configuration)
  - [Where to find datasets](#Where-to-find-datasets)
  - [Speech-to-Text and Text-to-Speech](#Speech-to-Text-and-Text-to-Speech)
  - [Speech to text and text to speech](#Speech-to-text-and-text-to-speech)
- [Examples](#examples)
  - [Convert speech to text](#Convert-speech-to-text)
  - [Use STT for your web projects](#Use-STT-for-your-web-projects)
- [Projects available](#projects-available)


You will find in this document all the instructions, documentation... for the Common Voice project.

# Introduction

> STT: Speech-To-Text

The CommonVoice FR project uses 🐸-STT ​​([Coqui-STT](https://github.com/coqui-ai/STT)), the following implementation from the [DeepSpeech](https://github.com/mozilla) project from the Mozilla Foundation, to continue transforming sound waves into text based on the learning algorithm proposed by the community.

# Canals

- **CommonVoice-rm** uses the **Common Voice** channel on Matrix for discussion and coordination: [register to the group](https://chat.mozilla.org/#/room/#common-voice-en:mozilla.org)
- [Discourse Mozilla (English)](https://discourse.mozilla.org/c/voice)

# Participate in CommonVoice _for all_

The **CommonVoice-rm** project uses datasets from the **Common Voice RM** project, you can help grow this database: [Participate in Common Voice](https://github.com/Common-Voice/CommonVoice/tree/master/CommonVoice#Participate-in-Common-Voice).

# Process for CommonVoice-en

It's a two-step process:

1. Help you convert text to audio and audio to text

## Getting started

### Installation and Setup

- Installation and configuration details are available in [CONTRIBUTING](https://github.com/Common-Voice/CommonVoice-rm/blob/master/STT/CONTRIBUTING.md)

### Where to find datasets

- <https://commonvoice.mozilla.org/fr/datasets>

### Speech-to-Text and Text-to-Speech

- [STT Models](https://coqui.ai/models)

### Speech to text and text to speech (en)

- Common Voice Corpora Creator: [EN](https://github.com/mozilla/voice-corpus-tools)
- Common Voice Sentence Collector: [EN](https://github.com/Common-Voice/sentence-collector)

## Examples

### Convert speech to text

- [convert speech to text](https://hacks.mozilla.org/2018/09/speech-recognition-deepspeech/)

### Use STT for your web projects

- [C#](https://github.com/coqui-ai/STT/tree/master/examples/net_framework)
- [NodeJS](https://github.com/coqui-ai/STT/tree/master/examples/nodejs_wav)
- [Streaming NodeJS](https://github.com/coqui-ai/STT/tree/master/examples/ffmpeg_vad_streaming)
- [Python streaming transcript](https://github.com/coqui-ai/STT/tree/master/examples/vad_transcriber)

# Projects available

- [mycroft](https://mycroft.ai/blog/STT-update/) – open source voice assistant
- [Leon](https://getleon.ai/) – open source personal assistant
- [Coqui-STT](https://github.com/coqui-ai/STT) – implementation of an STT architecture
- [Snips](https://snips.ai/) – decentralized and private voice assistant
- FusionPBX – telephone switching system installed in a private organization and used to transcribe telephone messages