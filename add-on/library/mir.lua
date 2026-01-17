---@meta

-------------------------------------------------------------------
-- Kontakt Lua API — Music Information Retrieval (MIR) Module
-------------------------------------------------------------------

---@class MIR
MIR = {}

--- Detects the fundamental MIDI pitch of an audio sample file.
--- Returns nil if detection fails.
---@param file string Absolute path of the audio file
---@return number? midi_pitch
function MIR.detect_pitch(file) end

--- Detects the peak level in dB of an audio sample.
---@param file string Absolute path of the audio file
---@return number? peak_db
function MIR.detect_peak(file) end

--- Detects the RMS level in dB of an audio sample.
--- Optional frame_size and hop_size control analysis resolution.
---@param file string Absolute path of the audio file
---@param frame_size? number Duration of frames (seconds)
---@param hop_size? number Hop size between frames (seconds)
---@return number? rms_db
function MIR.detect_rms(file, frame_size, hop_size) end

--- Detects perceived loudness in dB of an audio sample.
--- Optional frame_size and hop_size control analysis resolution.
---@param file string Absolute path of the audio file
---@param frame_size? number Duration of frames (seconds)
---@param hop_size? number Hop size between frames (seconds)
---@return number? loudness_db
function MIR.detect_loudness(file, frame_size, hop_size) end

--- Determines the sample type category of a sample file.
---@param file string Absolute path of the audio file
---@return string sample_type One of nil, "drum", "instrument"
function MIR.sample_type(file) end

--- Returns the drum type of file.
---@param file string Absolute path of the audio file
---@return string sample_type One of nil, "kick", "snare", "hihat_closed", "hihat_open", "tom", "cymbal", "clap", "shaker", "percussion_drum", "percussion_other"
function MIR.detect_drum_type(file) end

--- Returns the instrument type of file.
---@param file string Absolute path of the audio file
---@return string sample_type One of nil, "bass", "bowed_string", "brass", "flute", "guitar", "keyboard", "mallet", "organ", "plucked_string", "reed", "synth", "vocal"
function MIR.detect_instrument_type(file) end