---@meta

--------------------------------------------------------------------------------
-- Kontakt API Definitions (EmmyLua) for Lua Language Server
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Kontakt Module
--------------------------------------------------------------------------------

---@class Kontakt
---@field max_num_multi_scripts integer Maximum number of multi script slots. As of Kontakt 7.5, this constant returns 5.
---@field cc64_modes cc64_modes[] Table of CC64 (sustain pedal) modes (“midi_exclusive”, “pedal_and_cc”, “pedal_exclusive”).
---@field instrument_purge_modes instrument_purge_modes[] Available purge mode strings (“all_samples”, “reload_all_samples”, “reset_markers”, “update_sample_pool”).
---@field max_num_instrument_aux integer Maximum number of AUX sends per instrument (e.g., 4 as of Kontakt 7.5).
---@field max_num_instruments integer Maximum number of instruments in a multi (e.g., 64 as of Kontakt 7.5).
---@field max_num_scripts integer Maximum number of scripts per instrument (e.g., 5 as of Kontakt 7.5).
---@field max_num_voice_groups integer Maximum voice groups per instrument (e.g., 128 as of Kontakt 7.5).
---@field save_modes save_modes[] Save modes (“monolith”, “patch”, “samples”).
---@field voice_group_modes voice_group_modes[] Voice group mode options (“any”, “highest”, “lowest”, “newest”, “oldest”).
---@field voice_stealing_modes voice_stealing_modes[] Voice stealing mode options (“any”, “highest”, “lowest”, “newest”, “oldest”).
---@field max_num_sample_loops integer Maximum number of sample loops supported (as of Kontakt 7.5 this is 8).
---@field max_num_zones integer Maximum number of zones supported (as of Kontakt 7.5 this is 98304).
---@field sample_loop_modes sample_loop_modes[] Valid loop mode strings. (See sample_loop_modes reference on the Zone page.)
---@field zone_grid_modes zone_grid_modes[] Valid zone grid modes. (See zone_grid_modes reference on the Zone page.)
---@field bus_fx integer Points a preset loading function to the first instrument bus FX chain. Add 1–15 to reach other instrument bus FX chains.
---@field group_fx integer Points a preset loading function to the group FX chain.
---@field insert_fx integer Points a preset loading function to the insert FX chain.
---@field main_fx integer Points a preset loading function to the main FX chain. Does not apply to `load_fx_chain_preset()`.
---@field output_fx integer Points a preset loading function to the output FX chain. Does not apply to `load_fx_chain_preset()`.
---@field send_fx integer Points a preset loading function to the send FX chain.
---@field desktop_path string Returns the absolute path to the operating system’s Desktop folder.
---@field documents_path string Returns the absolute path to the operating system’s Documents folder.
---@field factory_path string Returns the Kontakt factory data path (contains wavetables, NKP presets, etc.).
---@field macos boolean Returns true if the system running the Lua script is macOS.
---@field ni_content_path string Returns the absolute path to the Native Instruments Content folder.
---@field non_player_content_base_path string Returns the non-Player content base path (optionally set in Kontakt’s Options > Loading pane).
---@field snapshot_path string Returns the user content snapshot path (contains snapshots saved by the user).
---@field windows boolean Returns true if the system running the Lua script is Windows.
---@field colored_output boolean Controls if terminal output is colored or not.
---@field edit_instrument integer|nil Index of the currently edited instrument (nil means multi).
---@field script_executed_from_instrument integer|nil Index of the instrument slot from which the script was loaded (nil if multi).
---@field script_file string Filename of the currently running Lua script, including extension.
---@field script_path string Absolute path to the folder containing the currently running Lua script.
---@field version string Current version of the running instance of Kontakt.
---@alias cc64_modes
---| "midi_exclusive"  CC64 affects only MIDI notes.
---| "pedal_and_cc"    CC64 affects both pedal and MIDI notes.
---| "pedal_exclusive"  CC64 affects only pedal notes.
---@alias instrument_purge_modes
---| "all_samples"          Purges all samples.
---| "reload_all_samples"   Reloads all samples.
---| "reset_markers"        Resets sample markers.
---| "update_sample_pool"   Updates the sample pool.
---@alias save_modes
---| "monolith"
---| "patch"
---| "samples"
---@alias voice_stealing_modes
---| "any"
---| "highest"
---| "lowest"
---| "newest"
---| "oldest"
---@alias sample_loop_modes
---| "off"           Looping disabled.
---| "until_end"     Loop until end.
---| "until_end_alt" Alternate until end.
---| "until_release" Loop until note release.
---| "until_release_alt" Alternate loop until release.
---@alias zone_grid_modes
---| "auto"  Grid mode auto.
---| "fixed" Fixed grid mode.
---| "none"  Grid off.
---@alias voice_group_modes
---| "any"
---| "highest"
---| "lowest"
---| "newest"
---| "oldest"

---@class Kontakt
Kontakt = {}

-------------------------------------------------------------------------------
-- Multi
-------------------------------------------------------------------------------
-- Get Property

---@return string Returns the name of the multi.
function Kontakt.get_multi_name() end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return string Returns the title of the multi script in the specified slot.
function Kontakt.get_multi_script_name(multi_script_idx) end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return string Returns the full source of the multi script in the specified slot.
function Kontakt.get_multi_script_source(multi_script_idx) end

---@return number Returns the number of instruments loaded in the multi.
function Kontakt.get_num_instruments() end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return boolean Returns true if the specified multi script slot is bypassed.
function Kontakt.is_multi_script_bypassed(multi_script_idx) end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return boolean Returns true if the specified multi script slot is password-protected.
function Kontakt.is_multi_script_protected(multi_script_idx) end

-- Set Property

---@param name string -- Sets the name of the multi.
function Kontakt.set_multi_name(name) end

---@param script_idx integer -- Zero-based index of the multi script slot.
---@param bypass boolean -- True to bypass the script, false to un-bypass.
function Kontakt.set_multi_script_bypassed(script_idx, bypass) end

---@param script_idx integer -- Zero-based index of the multi script slot.
---@param name string -- The new display name of the script.
function Kontakt.set_multi_script_name(script_idx, name) end

---@param script_idx integer -- Zero-based index of the multi script slot.
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

---@return integer? -- Next available instrument index (or nil if none).
function Kontakt.get_free_instrument_index() end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param aux_index integer -- Aux send index.
---@return number -- Returns aux send level in dB.
function Kontakt.get_instrument_aux_level(instrument_idx, aux_index) end

---@return integer[] -- Returns a table of all instrument indices currently loaded.
function Kontakt.get_instrument_indices() end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return integer -- Returns the MIDI channel of the instrument (0 = Omni, 1–64 channels A–D).
function Kontakt.get_instrument_midi_channel(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return boolean -- True if the instrument is muted.
function Kontakt.get_instrument_mute(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return string -- Returns the name of the instrument.
function Kontakt.get_instrument_name(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return table -- Returns an options table for the instrument.
function Kontakt.get_instrument_options(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return integer -- Returns the audio output channel of the instrument.
function Kontakt.get_instrument_output_channel(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return number -- Returns the panning of the instrument.
function Kontakt.get_instrument_pan(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return integer -- Returns the instrument’s polyphony (voice limit).
function Kontakt.get_instrument_polyphony(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer -- Script slot index.
---@return string -- Returns filename of linked script for this slot (if any).
function Kontakt.get_instrument_script_linked_filename(instrument_idx, script_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer -- Script slot index.
---@return string -- Returns the title of the script in this slot.
function Kontakt.get_instrument_script_name(instrument_idx, script_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer -- Script slot index.
---@return string -- Returns the script source for the given slot.
function Kontakt.get_instrument_script_source(instrument_idx, script_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return boolean -- True if the instrument is soloed.
function Kontakt.get_instrument_solo(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return number -- Returns tuning of the instrument in semitones.
function Kontakt.get_instrument_tune(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return number -- Returns the instrument’s overall volume in dB.
function Kontakt.get_instrument_volume(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return table -- Returns voice groups for the instrument (up to 128 entries).
function Kontakt.get_voice_groups(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer -- Script slot index.
---@return boolean -- True if this script is bypassed.
function Kontakt.is_instrument_script_bypassed(instrument_idx, script_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer -- Script slot index.
---@return boolean -- True if script slot is linked to a resource container file.
function Kontakt.is_instrument_script_linked(instrument_idx, script_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer -- Script slot index.
---@return boolean -- True if script is password-protected.
function Kontakt.is_instrument_script_protected(instrument_idx, script_idx) end

-- Set Property

--- Resets entire instrument to default.
---@param instrument_idx integer -- Zero-based index of the instrument.
function Kontakt.reset_instrument(instrument_idx) end 

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param aux_index integer -- Aux index.
---@param level number -- Sets aux send level in dB. Range is -math.huge … 12.0.
function Kontakt.set_instrument_aux_level(instrument_idx, aux_index, level) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param channel integer -- Sets MIDI channel (0 = Omni, 1–64).
function Kontakt.set_instrument_midi_channel(instrument_idx, channel) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param mute boolean -- Mutes/unmutes instrument.
function Kontakt.set_instrument_mute(instrument_idx, mute) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param name string -- Sets instrument name.
function Kontakt.set_instrument_name(instrument_idx, name) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param options table -- Sets selected instrument options.
function Kontakt.set_instrument_options(instrument_idx, options) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param channel integer -- Sets audio output for this instrument.
function Kontakt.set_instrument_output_channel(instrument_idx, channel) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param pan number -- Sets panning (-100 … 100).
function Kontakt.set_instrument_pan(instrument_idx, pan) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param voices number -- Sets maximum polyphony (≥1).
function Kontakt.set_instrument_polyphony(instrument_idx, voices) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer
---@param bypass boolean -- Bypasses/un-bypasses script slot.
function Kontakt.set_instrument_script_bypassed(instrument_idx, script_idx, bypass) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer
---@param filename string -- Sets linked filename in resource container.
function Kontakt.set_instrument_script_linked_filename(instrument_idx, script_idx, filename) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer
---@param name string -- Sets script title (no extension).
function Kontakt.set_instrument_script_name(instrument_idx, script_idx, name) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer
---@param source string -- Sets script source from absolute path.
function Kontakt.set_instrument_script_source(instrument_idx, script_idx, source) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param solo boolean -- Sets solo state.
function Kontakt.set_instrument_solo(instrument_idx, solo) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param tune number -- Sets tuning in semitones.
function Kontakt.set_instrument_tune(instrument_idx, tune) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param volume number -- Sets volume in dB.
function Kontakt.set_instrument_volume(instrument_idx, volume) end


---@class VoiceGroupOptions
---@field mode voice_group_modes|nil        @ Voice stealing mode (default: “oldest”).
---@field name string|nil                  @ Voice group name (default: ’’).
---@field voices integer|nil               @ Maximum voices for this voice group (default: 1).
---@field fade_time integer|nil            @ Voice fade time in milliseconds (default: 10).
---@field prefer_released boolean|nil      @ Prefer released voices (default: true).
---@field exclusive_group integer|nil      @ Exclusive group (default: nil).

--- Sets voice groups of the specified instrument as a table with a maximum of 128 entries, matching the total number of possible voice groups. Nil table entries will set voice group to default values.
---@param instrument_idx integer -- Zero-based index of the instrument.
---@param voice_groups VoiceGroupOptions -- Table of voice groups to set for the instrument.
function Kontakt.set_voice_groups(instrument_idx, voice_groups) end

-- Modifiers

--- Adds new instrument at given or next available instrument index. Returns the index of the new instrument. Pass this index to functions taking `instrument_idx` as an argument.
---@param instrument_idx? integer -- Zero-based index of the instrument.
---@return integer -- Returns the instrument slot of the new instrument.
function Kontakt.add_instrument(instrument_idx) end 

--- Adds instrument bank at given or next available instrument slot. Returns the instrument slot of the new instrument bank.
---@param bank_index? integer -- Bank index where instrument will be added.
---@return integer -- Returns the instrument slot of the new instrument bank.
function Kontakt.add_instrument_bank(bank_index) end 

--- Removes the instrument at the specified instrument index from the multi.
---@param instrument_idx integer -- Zero-based index of instrument to remove.
function Kontakt.remove_instrument(instrument_idx) end 

--- Removes the instrument bank at the specified instrument slot from the multi.
---@param bank_index integer -- Zero-based index of instrument bank to remove.
function Kontakt.remove_instrument_bank(bank_index) end 

-- File I/O (Instrument)

--- Loads an instrument to the specified slot index. If that slot is already occupied, next available slot is used. Returns the slot index of the new instrument. Note: contrary to most other functions, the slot index here can also refer to a slot within an instrument bank!
---@param path string -- Absolute path to instrument file.
---@param instrument_idx? integer -- Zero-based index of the instrument slot.
---@return integer -- Returns the instrument slot index of the loaded instrument.
function Kontakt.load_instrument(path, instrument_idx) end 

--- Loads the specified snapshot in the specified instrument index.
---@param instrument_idx integer -- Zero-based index of the instrument.
---@param snapshot_name string -- Instrument snapshot name to load (persisted UI state).
function Kontakt.load_snapshot(instrument_idx, snapshot_name) end 

---@class SaveInstrumentOptions
---@field mode save_modes|nil           @ default: "patch"
---@field absolute_paths boolean|nil     @ default: false
---@field compress_samples boolean|nil   @ default: false
---@field samples_sub_dir string|nil

--- Saves instrument.
---@param instrument_idx integer -- Zero-based index of the instrument.
---@param filename string -- Absolute path to save instrument file.
---@param options SaveInstrumentOptions|nil -- table with one or more of the following entries: `mode: save_modes (default: “patch”), absolute_paths: boolean (default: false), compress_samples: boolean (default: false), samples_sub_dir: string`, Individual entries of this table can be omitted. In that case the default value is used.
function Kontakt.save_instrument(instrument_idx, filename, options) end 

--- Saves the state of the instrument at the specified insturment index as a snapshot at the specified absolute path.
---@param instrument_idx integer -- Zero-based index of the instrument.
---@param filename string -- Absolute path to save instrument snapshot.
function Kontakt.save_snapshot(instrument_idx, filename) end 

-------------------------------------------------------------------------------
-- Group
-------------------------------------------------------------------------------

-- Get Property

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return string -- Returns the name of the specified group.
function Kontakt.get_group_name(instrument_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return number -- Returns the amplifier panorama of the specified group.
function Kontakt.get_group_pan(instrument_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return string -- Returns the playback mode of the group’s source module; one of group_playback_modes.
function Kontakt.get_group_playback_mode(instrument_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return table -- Returns a table of start options for this group.
function Kontakt.get_group_start_options(instrument_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return number -- Returns the tuning of the specified group in semitones.
function Kontakt.get_group_tune(instrument_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return number -- Returns the amplifier volume of the specified group in dB.
function Kontakt.get_group_volume(instrument_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return number -- Returns the total number of groups in the instrument.
function Kontakt.get_num_groups(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return number -- Returns the assigned voice group index or nil if not assigned.
function Kontakt.get_voice_group(instrument_idx, group_idx) end

-- Set Property

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param name string -- Sets the group’s display name.
function Kontakt.set_group_name(instrument_idx, group_idx, name) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param pan number -- Sets amplifier panorama of the group (-100.0 .. 100.0).
function Kontakt.set_group_pan(instrument_idx, group_idx, pan) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param mode string -- Playback mode from group_playback_modes.
function Kontakt.set_group_playback_mode(instrument_idx, group_idx, mode) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param options table -- A table of start options for the group; defaults may be omitted.
function Kontakt.set_group_start_options(instrument_idx, group_idx, options) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param tune number -- Group tuning in semitones (range -36.0 .. 36.0).
function Kontakt.set_group_tune(instrument_idx, group_idx, tune) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param volume number -- Group amplifier volume in dB.
function Kontakt.set_group_volume(instrument_idx, group_idx, volume) end

--- Assign a voice group to a group. In order to reset the assignment pass nil.
---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param voice_group integer|nil -- Assigns a voice group to the group; nil resets assignment.
function Kontakt.set_voice_group(instrument_idx, group_idx, voice_group) end

-- Modifiers

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return integer new_group_idx -- Adds a new group and returns its index.
function Kontakt.add_group(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group to remove.
---@return boolean success -- Removes the specified group.
function Kontakt.remove_group(instrument_idx, group_idx) end

-- File I/O

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param filename string -- Absolute path where the group will be saved.
---@param options? table -- Save options such as `mode`, `absolute_paths`, `compress_samples`, etc.
function Kontakt.save_group(instrument_idx, group_idx, filename, options) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param filename string -- Absolute path to load the group from.
---@param options? table -- Options such as `replace_zones`.
function Kontakt.load_group(instrument_idx, group_idx, filename, options) end

-------------------------------------------------------------------------------
-- Zone
-------------------------------------------------------------------------------

-- Get Property

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return integer -- Returns the total number of zones in the specified instrument.
function Kontakt.get_num_zones(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return integer -- Returns the loop count of the specified zone’s loop.
function Kontakt.get_sample_loop_count(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return integer -- Returns the loop length of the specified zone’s loop in sample frames.
function Kontakt.get_sample_loop_length(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return string -- Returns the loop mode of the specified zone’s loop. (See sample_loop_modes.)
function Kontakt.get_sample_loop_mode(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return integer -- Returns the loop start of the specified zone’s loop.
function Kontakt.get_sample_loop_start(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return number -- Returns the loop tuning of the specified zone’s loop in semitones.
function Kontakt.get_sample_loop_tune(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return integer -- Returns the loop crossfade time of the specified zone’s loop.
function Kontakt.get_sample_loop_xfade(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return table -- Returns a table containing the complete zone geometry (key/velocity ranges, root key, fades, etc.).
function Kontakt.get_zone_geometry(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the BPM of the specified zone.
function Kontakt.get_zone_grid_bpm(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return string -- Returns the grid mode of the specified zone. (See zone_grid_modes.)
function Kontakt.get_zone_grid_mode(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the index of the group which contains the specified zone.
function Kontakt.get_zone_group(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the high key of the specified zone.
function Kontakt.get_zone_high_key(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the high key crossfade span of the specified zone.
function Kontakt.get_zone_high_key_fade(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the high velocity of the specified zone.
function Kontakt.get_zone_high_velocity(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the high velocity crossfade span of the specified zone.
function Kontakt.get_zone_high_velocity_fade(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the low key of the specified zone.
function Kontakt.get_zone_low_key(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the low key crossfade span of the specified zone.
function Kontakt.get_zone_low_key_fade(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the low velocity of the specified zone.
function Kontakt.get_zone_low_velocity(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the low velocity crossfade span of the specified zone.
function Kontakt.get_zone_low_velocity_fade(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the panorama offset of the specified zone.
function Kontakt.get_zone_pan(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the root key of the specified zone.
function Kontakt.get_zone_root_key(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return string? -- Returns the absolute file path of the sample loaded in the specified zone.
function Kontakt.get_zone_sample(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer? -- Returns the number of audio channels in the sample loaded in the specified zone.
function Kontakt.get_zone_sample_channels(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the sample end position as negative frames relative to last sample frame.
function Kontakt.get_zone_sample_end(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer? -- Returns the length of the sample loaded in the specified zone (in frames).
function Kontakt.get_zone_sample_frames(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the sample start position for the specified zone (in frames).
function Kontakt.get_zone_sample_start(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return integer -- Returns the sample start modulation range (in frames).
function Kontakt.get_zone_sample_start_mod_range(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the tuning offset of the specified zone in semitones.
function Kontakt.get_zone_tune(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the volume offset of the specified zone in dB.
function Kontakt.get_zone_volume(instrument_idx, zone_idx) end

--------------------------------------------------------------------------------
-- Set Property
--------------------------------------------------------------------------------

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@param count integer -- Sets the loop count of the specified zone’s loop.
function Kontakt.set_sample_loop_count(instrument_idx, zone_idx, loop_idx, count) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@param frames integer -- Sets the length for the specified zone’s loop in sample frames.
function Kontakt.set_sample_loop_length(instrument_idx, zone_idx, loop_idx, frames) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@param mode string -- Sets the playback mode for the specified zone’s loop. (See sample_loop_modes.)
function Kontakt.set_sample_loop_mode(instrument_idx, zone_idx, loop_idx, mode) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@param frame integer -- Sets the start of the specified zone’s loop (in frames).
function Kontakt.set_sample_loop_start(instrument_idx, zone_idx, loop_idx, frame) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@param tune number -- Sets the tuning of the specified zone’s loop in semitones. Range -12.0 … 12.0.
function Kontakt.set_sample_loop_tune(instrument_idx, zone_idx, loop_idx, tune) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@param frames integer -- Sets the length of the specified zone’s loop xfade in sample frames.
function Kontakt.set_sample_loop_xfade(instrument_idx, zone_idx, loop_idx, frames) end

---@class ZoneGeometry
---@field root_key integer -- Default 36, range 0 … 127.
---@field low_key integer -- Default 0, range 0 … high_key.
---@field high_key integer -- Default 127, range low_key … 127.
---@field low_key_fade integer -- Default 0, range 0 … span.
---@field high_key_fade integer -- Default 0, range 0 … span.
---@field low_velocity integer -- Default 1, range 1 … high_velocity.
---@field high_velocity integer -- Default 127, range low_velocity … 127.
---@field low_velocity_fade integer -- Default 0, range 0 … span.
---@field high_velocity_fade integer -- Default 0, range 0 … span.

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param geometry ZoneGeometry -- Applies the provided zone geometry table (keys/velocities/fades/root key).
function Kontakt.set_zone_geometry(instrument_idx, zone_idx, geometry) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param mode string -- Grid mode. (See zone_grid_modes.)
---@param bpm number -- Grid BPM.
function Kontakt.set_zone_grid(instrument_idx, zone_idx, mode, bpm) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param group_idx integer -- Sets the group index for the specified zone (moves zone to that group).
function Kontakt.set_zone_group(instrument_idx, zone_idx, group_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param key integer -- Sets the zone high key. (See set_zone_geometry.)
function Kontakt.set_zone_high_key(instrument_idx, zone_idx, key) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param key_fade integer -- Sets the high key fade span. (See set_zone_geometry.)
function Kontakt.set_zone_high_key_fade(instrument_idx, zone_idx, key_fade) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param velocity integer -- Sets the zone high velocity. (See set_zone_geometry.)
function Kontakt.set_zone_high_velocity(instrument_idx, zone_idx, velocity) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param velocity_fade integer -- Sets the high velocity fade span. (See set_zone_geometry.)
function Kontakt.set_zone_high_velocity_fade(instrument_idx, zone_idx, velocity_fade) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param key integer -- Sets the zone low key. (See set_zone_geometry.)
function Kontakt.set_zone_low_key(instrument_idx, zone_idx, key) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param key_fade integer -- Sets the low key fade span. (See set_zone_geometry.)
function Kontakt.set_zone_low_key_fade(instrument_idx, zone_idx, key_fade) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param velocity integer -- Sets the zone low velocity. (See set_zone_geometry.)
function Kontakt.set_zone_low_velocity(instrument_idx, zone_idx, velocity) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param velocity_fade integer -- Sets the low velocity fade span. (See set_zone_geometry.)
function Kontakt.set_zone_low_velocity_fade(instrument_idx, zone_idx, velocity_fade) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param pan number -- Sets the panorama offset. Range -100.0 … 100.0.
function Kontakt.set_zone_pan(instrument_idx, zone_idx, pan) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param key integer -- Sets the zone root key. (See set_zone_geometry.)
function Kontakt.set_zone_root_key(instrument_idx, zone_idx, key) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param filename string -- Sets the absolute path of the sample to be loaded in the specified zone.
function Kontakt.set_zone_sample(instrument_idx, zone_idx, filename) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param frame integer -- Sets sample end as negative frames relative to last sample frame.
function Kontakt.set_zone_sample_end(instrument_idx, zone_idx, frame) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param frame integer -- Sets the sample start (in frames).
function Kontakt.set_zone_sample_start(instrument_idx, zone_idx, frame) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param frame integer -- Sets the sample start modulation range (in frames).
function Kontakt.set_zone_sample_start_mod_range(instrument_idx, zone_idx, frame) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param tune number -- Sets the tuning offset in semitones. Range -36.0 … 36.0.
function Kontakt.set_zone_tune(instrument_idx, zone_idx, tune) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param volume number -- Sets the volume offset in dB. Range -36.0 … 36.0.
function Kontakt.set_zone_volume(instrument_idx, zone_idx, volume) end

--------------------------------------------------------------------------------
-- Modifiers
--------------------------------------------------------------------------------

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Group index for the new zone.
---@param filename string -- Absolute path to the sample file.
---@return integer -- Returns the new zone index.
function Kontakt.add_zone(instrument_idx, group_idx, filename) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index to remove.
function Kontakt.remove_zone(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index whose loops should be restored from sample metadata (if any).
function Kontakt.restore_loops_from_sample(instrument_idx, zone_idx) end


-------------------------------------------------------------------------------
-- Presets
-------------------------------------------------------------------------------

---Loads a source preset file (`.NKP`) to the specified group of an instrument.
---@param filename string -- Absolute path of the source preset file.
---@param instrument_idx integer -- Index of the target instrument.
---@param group_idx integer -- Index of the group within the instrument.
---@return integer result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_source_preset(filename, instrument_idx, group_idx) end

---Loads an effect preset file (`.NKP`) to the specified location based on its FX chain target.
---@param filename string -- Absolute path of the FX preset file.
---@param instrument_or_output_idx integer -- Instrument index (for instrument FX) or output index (for output FX).
---@param group_idx integer -- Group index (only relevant when using `group_fx`). Otherwise, set to `-1`. 
---@param generic integer|Kontakt -- A constant specifying the FX chain target (e.g., `Kontakt.group_fx`). 
---@return integer result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_fx_preset(filename, instrument_or_output_idx, group_idx, generic) end

---Loads a multi script preset file (`.NKP`) into the specified multi script slot of an instrument.
---@param filename string -- Absolute path of the multi script preset file.
---@param instrument_idx integer -- Instrument index on which to apply the preset.
---@param multi_script_idx integer -- Zero-based index of the multi script slot.
---@return integer result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_multi_script_preset(filename, instrument_idx, multi_script_idx) end

---Loads a script preset file (`.NKP`) into the specified script slot of an instrument.
---@param filename string -- Absolute path of the script preset file.
---@param instrument_idx integer -- Instrument index on which to apply the preset.
---@param script_idx integer -- Script slot index in the instrument.
---@return integer result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_script_preset(filename, instrument_idx, script_idx) end

---Loads a complete FX chain preset (`.NKP`) to a specific location based on FX chain target.
---@param filename string -- Absolute path of the FX chain preset file.
---@param instrument_idx integer -- Target instrument index.
---@param group_idx integer -- Group index (only relevant when `generic` is `Kontakt.group_fx`). Otherwise, set to `-1`. 
---@param generic integer|Kontakt -- Constant specifying which FX chain to load into (e.g., `Kontakt.insert_fx`). 
---@return integer result -- A result code indicating success (non-nil) or failure.
function Kontakt.load_fx_chain_preset(filename, instrument_idx, group_idx, generic) end


-------------------------------------------------------------------------------
-- Utility
-------------------------------------------------------------------------------

-- Functions

--- Unit test helper: calls `test` expecting it to fail; throws an error if it doesn’t.
---@param test function 
function Kontakt.assert_fail(test) end

--- Creates a new resource container (with the obligatory Resources folder) or updates an existing resource container. If the .nkr extension is not a part of the filename string, it will be added automatically.
---@param instrument_idx integer -- Index of the instrument for which to create or update a resource container.
---@param filename string -- Absolute filename of the resource container to create or update (will add .nkr if missing).
function Kontakt.create_resource_container(instrument_idx, filename) end

--- Links an existing resource container to the instrument. If the .nkr extension is not a part of the filename string, it will be added automatically. Note that this command does not require the Resources folder to exist.
---@param instrument_idx integer -- Index of the instrument for which to link an existing resource container.
---@param filename string -- Filename of the resource container to link (will add .nkr if missing).
function Kontakt.link_resource_container(instrument_idx, filename) end

--- Extracts information from an instrument on disk.
---@param filename string -- Filename of an instrument on disk for which to extract file info.
---@return table fileinfo -- Table with fields: `file`, `format`, `version`, `library`, `num_instruments`, `num_groups`, `num_zones`.
function Kontakt.get_file_info(filename) end

--- Runs one of available purge actions for the specified instrument.
---@param instrument_idx integer -- Index of the instrument on which to run one of the preset purge actions.
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

