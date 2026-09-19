---@meta

-------------------------------------------------------------------
-- Kontakt Lua API — Music Information Retrieval (MIR) Module
-------------------------------------------------------------------

---@alias mir_sample_type
---| 'drum'
---| 'instrument'

---@alias mir_drum_type
---| 'kick'
---| 'snare'
---| 'hihat_closed'
---| 'hihat_open'
---| 'tom'
---| 'cymbal'
---| 'clap'
---| 'shaker'
---| 'percussion_drum'
---| 'percussion_other'

---@alias mir_instrument_type
---| 'bass'
---| 'bowed_string'
---| 'brass'
---| 'flute'
---| 'guitar'
---| 'keyboard'
---| 'mallet'
---| 'organ'
---| 'plucked_string'
---| 'reed'
---| 'synth'
---| 'vocal'

---Music-information-retrieval functions for analyzing individual audio files.
---All file arguments must be absolute paths. Analysis functions return `nil`
---when they cannot detect the requested property.
---@class MIR
MIR = {}

---Detects the fundamental pitch of a monophonic or single-note sample. The
---result uses the MIDI-note scale and may be fractional: 69 is 440 Hz. Kontakt
---supports pitches from MIDI note 15 (approximately 20 Hz) through 120
---(approximately 8.4 kHz).
---@param file string Absolute path of the audio file.
---@return number? midi_pitch Detected MIDI pitch, or `nil` if detection fails.
function MIR.detect_pitch(file) end

---Detects the sample's maximum peak level. Levels are expressed in dB and do
---not exceed 0 dB.
---@param file string Absolute path of the audio file.
---@return number? peak_db Peak level in dB, or `nil` if detection fails.
function MIR.detect_peak(file) end

---Detects the RMS level in blocks and returns the highest block value. Levels
---are expressed in dB and do not exceed 0 dB. Omit both timing arguments to use
---Kontakt's defaults of 0.4-second frames and a 0.1-second hop size.
---@overload fun(file: string): number?
---@param file string Absolute path of the audio file.
---@param frame_size number Duration of each analysis frame in seconds.
---@param hop_size number Time in seconds between consecutive frames.
---@return number? rms_db Highest detected RMS level, or `nil` if detection fails.
function MIR.detect_rms(file, frame_size, hop_size) end

---Detects perceived loudness in blocks and returns the loudest block value.
---Levels are expressed in dB and do not exceed 0 dB. Omit both timing arguments
---to use Kontakt's defaults of 0.4-second frames and a 0.1-second hop size.
---@overload fun(file: string): number?
---@param file string Absolute path of the audio file.
---@param frame_size number Duration of each analysis frame in seconds.
---@param hop_size number Time in seconds between consecutive frames.
---@return number? loudness_db Loudest detected level, or `nil` if detection fails.
function MIR.detect_loudness(file, frame_size, hop_size) end

---Classifies a sample as a drum or pitched instrument.
---@param file string Absolute path of the audio file.
---@return mir_sample_type? sample_type Category, or `nil` if classification fails.
function MIR.sample_type(file) end

---Classifies the drum sound in a sample.
---@param file string Absolute path of the audio file.
---@return mir_drum_type? drum_type Category, or `nil` if classification fails.
function MIR.detect_drum_type(file) end

---Classifies the instrument sound in a sample.
---@param file string Absolute path of the audio file.
---@return mir_instrument_type? instrument_type Category, or `nil` if classification fails.
function MIR.detect_instrument_type(file) end

---Analyzes a sample and suggests loop start and end positions. With only a file
---argument, Kontakt chooses all search constraints automatically. Otherwise,
---provide all three constraints to limit the search range and loop length.
---
---The returned positions can be assigned to a zone's loop start and used to
---derive its loop length. Both results are `nil` when detection fails.
---@overload fun(file: string): integer?, integer?
---@param file string Absolute path of the audio file.
---@param min_start number Earliest loop-start position considered by the algorithm.
---@param max_end number Latest loop-end position considered by the algorithm.
---@param min_length number Minimum loop length considered by the algorithm.
---@return integer? loop_start Suggested loop-start position in sample frames.
---@return integer? loop_end Suggested loop-end position in sample frames.
function MIR.find_loop(file, min_start, max_end, min_length) end
