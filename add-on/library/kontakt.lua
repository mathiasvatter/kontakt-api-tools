---@meta

--------------------------------------------------------------------------------
-- Kontakt API Definitions (EmmyLua) for Lua Language Server
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Kontakt Module
--------------------------------------------------------------------------------

---@class Kontakt
---@field max_num_multi_scripts integer Maximum number of multi script slots. As of Kontakt 7.5, this constant returns 5.
---@field cc64_modes table -- Table of CC64 (sustain pedal) modes (“midi_exclusive”, “pedal_and_cc”, “pedal_exclusive”).
---@field instrument_purge_modes table -- Available purge mode strings (“all_samples”, “reload_all_samples”, “reset_markers”, “update_sample_pool”).
---@field max_num_instrument_aux number -- Maximum number of AUX sends per instrument (e.g., 4 as of Kontakt 7.5).
---@field max_num_instruments number -- Maximum number of instruments in a multi (e.g., 64 as of Kontakt 7.5).
---@field max_num_scripts number -- Maximum number of scripts per instrument (e.g., 5 as of Kontakt 7.5).
---@field max_num_voice_groups number -- Maximum voice groups per instrument (e.g., 128 as of Kontakt 7.5).
---@field save_modes table -- Save modes (“monolith”, “patch”, “samples”).
---@field voice_stealing_modes table -- Voice stealing mode options (“any”, “highest”, “lowest”, “newest”, “oldest”).
---@field max_num_sample_loops number -- Maximum number of sample loops supported (as of Kontakt 7.5 this is 8).
---@field max_num_zones number -- Maximum number of zones supported (as of Kontakt 7.5 this is 98304).
---@field bus_fx number -- Points a preset loading function to the first instrument bus FX chain. Add 1–15 to reach other instrument bus FX chains.
---@field group_fx number -- Points a preset loading function to the group FX chain.
---@field insert_fx number -- Points a preset loading function to the insert FX chain.
---@field main_fx number -- Points a preset loading function to the main FX chain. Does not apply to `load_fx_chain_preset()`.
---@field output_fx number -- Points a preset loading function to the output FX chain. Does not apply to `load_fx_chain_preset()`.
---@field send_fx number -- Points a preset loading function to the send FX chain.
---@field desktop_path string -- Returns the absolute path to the operating system’s Desktop folder.
---@field documents_path string -- Returns the absolute path to the operating system’s Documents folder.
---@field factory_path string -- Returns the Kontakt factory data path (contains wavetables, NKP presets, etc.).
---@field macos boolean -- Returns true if the system running the Lua script is macOS.
---@field ni_content_path string -- Returns the absolute path to the Native Instruments Content folder.
---@field non_player_content_base_path string -- Returns the non-Player content base path (optionally set in Kontakt’s Options > Loading pane).
---@field snapshot_path string -- Returns the user content snapshot path (contains snapshots saved by the user).
---@field windows boolean -- Returns true if the system running the Lua script is Windows.
---@field colored_output boolean -- Controls if terminal output is colored or not.
---@field edit_instrument number|nil -- Index of the currently edited instrument (nil means multi).
---@field script_executed_from_instrument number|nil -- Index of the instrument slot from which the script was loaded (nil if multi).
---@field script_file string -- Filename of the currently running Lua script, including extension.
---@field script_path string -- Absolute path to the folder containing the currently running Lua script.
---@field version string -- Current version of the running instance of Kontakt.
---@alias sample_loop_modes
---| "off"           -- Looping disabled.
---| "until_end"     -- Loop until end.
---| "until_end_alt" -- Alternate until end.
---| "until_release" -- Loop until note release.
---| "until_release_alt" -- Alternate loop until release.
---@alias zone_grid_modes
---| "auto"  -- Grid mode auto.
---| "fixed" -- Fixed grid mode.
---| "none"  -- Grid off.

Kontakt = {}

-------------------------------------------------------------------------------
-- Multi
-------------------------------------------------------------------------------
-- Get Property

---@return string -- Returns the name of the multi.
function Kontakt.get_multi_name() end

---@param multi_script_idx number -- The zero-based index of the multi script slot.
---@return string -- Returns the title of the multi script in the specified slot.
function Kontakt.get_multi_script_name(multi_script_idx) end

---@param multi_script_idx number -- The zero-based index of the multi script slot.
---@return string -- Returns the full source of the multi script in the specified slot.
function Kontakt.get_multi_script_source(multi_script_idx) end

---@return number -- Returns the number of instruments loaded in the multi.
function Kontakt.get_num_instruments() end

---@param multi_script_idx number -- The zero-based index of the multi script slot.
---@return boolean -- Returns true if the specified multi script slot is bypassed.
function Kontakt.is_multi_script_bypassed(multi_script_idx) end

---@param multi_script_idx number -- The zero-based index of the multi script slot.
---@return boolean -- Returns true if the specified multi script slot is password-protected.
function Kontakt.is_multi_script_protected(multi_script_idx) end

-- Set Property

---@param name string -- Sets the name of the multi.
function Kontakt.set_multi_name(name) end

---@param script_idx number -- Zero-based index of the multi script slot.
---@param bypass boolean -- True to bypass the script, false to un-bypass.
function Kontakt.set_multi_script_bypassed(script_idx, bypass) end

---@param script_idx number -- Zero-based index of the multi script slot.
---@param name string -- The new display name of the script.
function Kontakt.set_multi_script_name(script_idx, name) end

---@param script_idx number -- Zero-based index of the multi script slot.
---@param source string -- Absolute file path or script source text for this slot.
function Kontakt.set_multi_script_source(script_idx, source) end

-- Modifiers

---Resets the entire multi to its default (empty) state.
function Kontakt.reset_multi() end

-- File I/O

---@param filename string -- Absolute path where the multi file will be saved.
---@param options table -- Save options (e.g., mode, absolute_paths, compress_samples, samples_sub_dir).
function Kontakt.save_multi(filename, options) end

---@param filename string -- Absolute path of the multi file to load.
function Kontakt.load_multi(filename) end

-------------------------------------------------------------------------------
-- Instrument
-------------------------------------------------------------------------------

-- Get Property

---@param instrument_idx number -- Index of the instrument.
---@return number? -- Next available instrument index (or nil if none).
function Kontakt.get_free_instrument_index(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param aux_index number -- Aux send index.
---@return number -- Returns aux send level in dB.
function Kontakt.get_instrument_aux_level(instrument_idx, aux_index) end

---@return number[] -- Returns a table of all instrument indices currently loaded.
function Kontakt.get_instrument_indices() end

---@param instrument_idx number -- Index of the instrument.
---@return number -- Returns the MIDI channel of the instrument (0 = Omni, 1–64 channels A–D).
function Kontakt.get_instrument_midi_channel(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return boolean -- True if the instrument is muted.
function Kontakt.get_instrument_mute(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return string -- Returns the name of the instrument.
function Kontakt.get_instrument_name(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return table -- Returns an options table for the instrument.
function Kontakt.get_instrument_options(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return number -- Returns the audio output channel of the instrument.
function Kontakt.get_instrument_output_channel(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return number -- Returns the panning of the instrument.
function Kontakt.get_instrument_pan(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return number -- Returns the instrument’s polyphony (voice limit).
function Kontakt.get_instrument_polyphony(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param script_idx number -- Script slot index.
---@return string -- Returns filename of linked script for this slot (if any).
function Kontakt.get_instrument_script_linked_filename(instrument_idx, script_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param script_idx number -- Script slot index.
---@return string -- Returns the title of the script in this slot.
function Kontakt.get_instrument_script_name(instrument_idx, script_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param script_idx number -- Script slot index.
---@return string -- Returns the script source for the given slot.
function Kontakt.get_instrument_script_source(instrument_idx, script_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return boolean -- True if the instrument is soloed.
function Kontakt.get_instrument_solo(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return number -- Returns tuning of the instrument in semitones.
function Kontakt.get_instrument_tune(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return number -- Returns the instrument’s overall volume in dB.
function Kontakt.get_instrument_volume(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@return table -- Returns voice groups for the instrument (up to 128 entries).
function Kontakt.get_voice_groups(instrument_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param script_idx number -- Script slot index.
---@return boolean -- True if this script is bypassed.
function Kontakt.is_instrument_script_bypassed(instrument_idx, script_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param script_idx number -- Script slot index.
---@return boolean -- True if script slot is linked to a resource container file.
function Kontakt.is_instrument_script_linked(instrument_idx, script_idx) end

---@param instrument_idx number -- Index of the instrument.
---@param script_idx number -- Script slot index.
---@return boolean -- True if script is password-protected.
function Kontakt.is_instrument_script_protected(instrument_idx, script_idx) end

-- Set Property

---@param instrument_idx number -- Index of the instrument.
function Kontakt.reset_instrument(instrument_idx) end -- Resets entire instrument to default.

---@param instrument_idx number
---@param aux_index number
---@param level number -- Sets aux send level in dB.
function Kontakt.set_instrument_aux_level(instrument_idx, aux_index, level) end

---@param instrument_idx number
---@param channel number -- Sets MIDI channel (0 = Omni, 1–64).
function Kontakt.set_instrument_midi_channel(instrument_idx, channel) end

---@param instrument_idx number
---@param mute boolean -- Mutes/unmutes instrument.
function Kontakt.set_instrument_mute(instrument_idx, mute) end

---@param instrument_idx number
---@param name string -- Sets instrument name.
function Kontakt.set_instrument_name(instrument_idx, name) end

---@param instrument_idx number
---@param options table -- Sets selected instrument options.
function Kontakt.set_instrument_options(instrument_idx, options) end

---@param instrument_idx number
---@param channel number -- Sets audio output for this instrument.
function Kontakt.set_instrument_output_channel(instrument_idx, channel) end

---@param instrument_idx number
---@param pan number -- Sets panning (-100 … 100).
function Kontakt.set_instrument_pan(instrument_idx, pan) end

---@param instrument_idx number
---@param voices number -- Sets maximum polyphony (≥1).
function Kontakt.set_instrument_polyphony(instrument_idx, voices) end

---@param instrument_idx number
---@param script_idx number
---@param bypass boolean -- Bypasses/un-bypasses script slot.
function Kontakt.set_instrument_script_bypassed(instrument_idx, script_idx, bypass) end

---@param instrument_idx number
---@param script_idx number
---@param filename string -- Sets linked filename in resource container.
function Kontakt.set_instrument_script_linked_filename(instrument_idx, script_idx, filename) end

---@param instrument_idx number
---@param script_idx number
---@param name string -- Sets script title (no extension).
function Kontakt.set_instrument_script_name(instrument_idx, script_idx, name) end

---@param instrument_idx number
---@param script_idx number
---@param source string -- Sets script source from absolute path.
function Kontakt.set_instrument_script_source(instrument_idx, script_idx, source) end

---@param instrument_idx number
---@param solo boolean -- Sets solo state.
function Kontakt.set_instrument_solo(instrument_idx, solo) end

---@param instrument_idx number
---@param tune number -- Sets tuning in semitones.
function Kontakt.set_instrument_tune(instrument_idx, tune) end

---@param instrument_idx number
---@param volume number -- Sets volume in dB.
function Kontakt.set_instrument_volume(instrument_idx, volume) end

-- Modifiers

--- Adds new instrument.
---@param instrument_idx number -- Index of the instrument.
function Kontakt.add_instrument(instrument_idx) end 

--- Adds instrument bank.
---@param bank_index number -- Bank index where instrument will be added.
function Kontakt.add_instrument_bank(bank_index) end 

--- Removes instrument.
---@param instrument_idx number -- Index of instrument to remove.
function Kontakt.remove_instrument(instrument_idx) end 

--- Removes instrument bank.
---@param bank_index number -- Index of instrument bank to remove.
function Kontakt.remove_instrument_bank(bank_index) end 

-- File I/O (Instrument)

--- Loads instrument from disk.
---@param path string -- Absolute path to instrument file.
function Kontakt.load_instrument(path) end 

--- Loads snapshot.
---@param snapshot_name string -- Instrument snapshot name to load (persisted UI state).
function Kontakt.load_snapshot(snapshot_name) end 

--- Saves instrument.
---@param path string -- Absolute path to save instrument file.
---@param mode string -- One of save_modes (e.g., “monolith”, “patch”, “samples”).
function Kontakt.save_instrument(path, mode) end 

--- Saves snapshot.
---@param path string -- Absolute path to save instrument snapshot.
function Kontakt.save_snapshot(path) end 

-------------------------------------------------------------------------------
-- Zone
-------------------------------------------------------------------------------

-- Get Property

---@param instrument_idx number -- The instrument index to query.
---@return number -- Returns the total number of zones in the specified instrument.
function Kontakt.get_num_zones(instrument_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zero-based zone index.
---@param loop_idx number -- Loop index.
---@return number -- Returns the loop count of the specified loop in the specified zone.
function Kontakt.get_sample_loop_count(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@param loop_idx number -- Loop index.
---@return number -- Returns the loop length in sample frames.
function Kontakt.get_sample_loop_length(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@param loop_idx number -- Loop index.
---@return sample_loop_modes -- Returns the loop playback mode (one of sample_loop_modes).
function Kontakt.get_sample_loop_mode(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@param loop_idx number -- Loop index.
---@return number -- Returns the loop start position in sample frames.
function Kontakt.get_sample_loop_start(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@param loop_idx number -- Loop index.
---@return number -- Returns the loop tuning offset in semitones.
function Kontakt.get_sample_loop_tune(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@param loop_idx number -- Loop index.
---@return number -- Returns the crossfade length in sample frames.
function Kontakt.get_sample_loop_xfade(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return table -- Returns a table containing zone geometry (key/velocity bounds and fades).
function Kontakt.get_zone_geometry(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return number -- Returns the grid BPM for the specified zone.
function Kontakt.get_zone_grid_bpm(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return zone_grid_modes -- Returns the grid mode of the specified zone.
function Kontakt.get_zone_grid_mode(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return number -- Returns the group index that contains the zone.
function Kontakt.get_zone_group(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return number -- Returns the high key boundary of the zone.
function Kontakt.get_zone_high_key(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return number -- Returns the high key fade span.
function Kontakt.get_zone_high_key_fade(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return number -- Returns the high velocity boundary of the zone.
function Kontakt.get_zone_high_velocity(instrument_idx, zone_idx) end

---@param instrument_idx number -- Instrument index.
---@param zone_idx number -- Zone index.
---@return number -- Returns the high velocity fade span.
function Kontakt.get_zone_high_velocity_fade(instrument_idx, zone_idx) end

-- Set Property

-- Sets the loop count of the specified loop in the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param loop_idx number -- The zero-based loop index.
---@param count number -- New loop count value.
function Kontakt.set_sample_loop_count(instrument_idx, zone_idx, loop_idx, count) end

-- Sets the loop length (in frames) for the specified zone loop.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param loop_idx number -- The zero-based loop index.
---@param frames number -- New loop length in sample frames.
function Kontakt.set_sample_loop_length(instrument_idx, zone_idx, loop_idx, frames) end

-- Sets the playback mode for the specified loop.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param loop_idx number -- The zero-based loop index.
---@param mode string -- New loop mode, one of `"off"`, `"until_end"`, etc.
function Kontakt.set_sample_loop_mode(instrument_idx, zone_idx, loop_idx, mode) end

-- Sets the loop start position (in frames) for the specified loop.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param loop_idx number -- The zero-based loop index.
---@param frame number -- New loop start frame.
function Kontakt.set_sample_loop_start(instrument_idx, zone_idx, loop_idx, frame) end

-- Sets the tuning offset (in semitones) for the specified loop.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param loop_idx number -- The zero-based loop index.
---@param tune number -- New tuning offset in semitones.
function Kontakt.set_sample_loop_tune(instrument_idx, zone_idx, loop_idx, tune) end

-- Sets the crossfade length (in frames) for the specified loop.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param loop_idx number -- The zero-based loop index.
---@param frames number -- New crossfade length in frames.
function Kontakt.set_sample_loop_xfade(instrument_idx, zone_idx, loop_idx, frames) end

-- Applies a complete geometry configuration to the zone (keys, velocities, fades).
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param geometry table -- Table of zone geometry fields (root_key, key/velocity ranges, fades).
function Kontakt.set_zone_geometry(instrument_idx, zone_idx, geometry) end

-- Sets the grid mode and BPM for the specified zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param mode zone_grid_modes -- New grid mode (`"auto"`, `"fixed"`, or `"none"`).
---@param bpm number -- Grid BPM value.
function Kontakt.set_zone_grid(instrument_idx, zone_idx, mode, bpm) end

-- Sets the group index for the specified zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param group_idx number -- The group index to assign to the zone.
function Kontakt.set_zone_group(instrument_idx, zone_idx, group_idx) end

-- Sets the high key boundary for the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param key number -- High key boundary for the zone.
function Kontakt.set_zone_high_key(instrument_idx, zone_idx, key) end

-- Sets the high key fade span for the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param key_fade number -- High key fade span.
function Kontakt.set_zone_high_key_fade(instrument_idx, zone_idx, key_fade) end

-- Sets the high velocity boundary for the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param velocity number -- High velocity boundary.
function Kontakt.set_zone_high_velocity(instrument_idx, zone_idx, velocity) end

-- Sets the high velocity fade span for the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param velocity_fade number -- High velocity fade span.
function Kontakt.set_zone_high_velocity_fade(instrument_idx, zone_idx, velocity_fade) end

-- Sets the low key boundary for the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param key number -- Low key boundary.
function Kontakt.set_zone_low_key(instrument_idx, zone_idx, key) end

-- Sets the low key fade span for the zone.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index.
---@param key_fade number -- Low key fade span.
function Kontakt.set_zone_low_key_fade(instrument_idx, zone_idx, key_fade) end

-- Modifiers

-- Adds a new zone to the specified instrument and group, loading the given sample, and returns the new zone’s index.
---@param instrument_idx number -- The instrument index to modify.
---@param group_idx number -- The group index to which the new zone will belong.
---@param filename string -- The absolute file path for the sample to load into the new zone.
---@return number zone_idx -- Index of the newly added zone.
function Kontakt.add_zone(instrument_idx, group_idx, filename) end

-- Removes the specified zone from the instrument at the given index.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index to remove.
function Kontakt.remove_zone(instrument_idx, zone_idx) end

-- Resets the loop points of the specified zone from the loop metadata of its sample, if available.
---@param instrument_idx number -- The instrument index to modify.
---@param zone_idx number -- The zero-based zone index for which to restore loops.
function Kontakt.restore_loops_from_sample(instrument_idx, zone_idx) end


-------------------------------------------------------------------------------
-- Presets
-------------------------------------------------------------------------------

---Loads a source preset file (`.NKP`) to the specified group of an instrument.
---@param filename string -- Absolute path of the source preset file.
---@param instrument_idx number -- Index of the target instrument.
---@param group_idx number -- Index of the group within the instrument.
---@return number result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_source_preset(filename, instrument_idx, group_idx) end

---Loads an effect preset file (`.NKP`) to the specified location based on its FX chain target.
---@param filename string -- Absolute path of the FX preset file.
---@param instrument_or_output_idx number -- Instrument index (for instrument FX) or output index (for output FX).
---@param group_idx number -- Group index (only relevant when using `group_fx`). Otherwise, set to `-1`. 
---@param generic number|Kontakt -- A constant specifying the FX chain target (e.g., `Kontakt.group_fx`). 
---@return number result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_fx_preset(filename, instrument_or_output_idx, group_idx, generic) end

---Loads a multi script preset file (`.NKP`) into the specified multi script slot of an instrument.
---@param filename string -- Absolute path of the multi script preset file.
---@param instrument_idx number -- Instrument index on which to apply the preset.
---@param multi_script_idx number -- Zero-based index of the multi script slot.
---@return number result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_multi_script_preset(filename, instrument_idx, multi_script_idx) end

---Loads a script preset file (`.NKP`) into the specified script slot of an instrument.
---@param filename string -- Absolute path of the script preset file.
---@param instrument_idx number -- Instrument index on which to apply the preset.
---@param script_idx number -- Script slot index in the instrument.
---@return number result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_script_preset(filename, instrument_idx, script_idx) end

---Loads a complete FX chain preset (`.NKP`) to a specific location based on FX chain target.
---@param filename string -- Absolute path of the FX chain preset file.
---@param instrument_idx number -- Target instrument index.
---@param group_idx number -- Group index (only relevant when `generic` is `Kontakt.group_fx`). Otherwise, set to `-1`. 
---@param generic number|Kontakt -- Constant specifying which FX chain to load into (e.g., `Kontakt.insert_fx`). 
---@return number result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_fx_chain_preset(filename, instrument_idx, group_idx, generic) end


-------------------------------------------------------------------------------
-- Utility
-------------------------------------------------------------------------------

-- Functions

--- Unit test helper: calls `test` expecting it to fail; throws an error if it doesn’t.
---@param test function 
function Kontakt.assert_fail(test) end

--- Creates a new resource container (with the obligatory Resources folder) or updates an existing resource container. If the .nkr extension is not a part of the filename string, it will be added automatically.
---@param instrument_idx number -- Index of the instrument for which to create or update a resource container.
---@param filename string -- Absolute filename of the resource container to create or update (will add .nkr if missing).
function Kontakt.create_resource_container(instrument_idx, filename) end

--- Links an existing resource container to the instrument. If the .nkr extension is not a part of the filename string, it will be added automatically. Note that this command does not require the Resources folder to exist.
---@param instrument_idx number -- Index of the instrument for which to link an existing resource container.
---@param filename string -- Filename of the resource container to link (will add .nkr if missing).
function Kontakt.link_resource_container(instrument_idx, filename) end

--- Extracts information from an instrument on disk.
---@param filename string -- Filename of an instrument on disk for which to extract file info.
---@return table fileinfo -- Table with fields: `file`, `format`, `version`, `library`, `num_instruments`, `num_groups`, `num_zones`.
function Kontakt.get_file_info(filename) end

--- Runs one of available purge actions for the specified instrument.
---@param instrument_idx number -- Index of the instrument on which to run one of the preset purge actions.
---@param mode string -- Purge mode (e.g., `"all_samples"`, `"reload_all_samples"`, etc.).
function Kontakt.instrument_purge(instrument_idx, mode) end

-- File I/O

--- Decodes an NCW sample back to uncompressed WAV format.
---@param source string -- Path to the NCW file to decode.
---@param target string -- Path where the decoded WAV file will be written.
function Kontakt.ncw_decode(source, target) end

--- Encodes a WAV or AIFF sample to losslessly compressed NCW format.
---@param source string -- Path to a WAV or AIFF file to encode to NCW (lossless).
---@param target string -- Path where the encoded NCW file will be written.
function Kontakt.ncw_encode(source, target) end

