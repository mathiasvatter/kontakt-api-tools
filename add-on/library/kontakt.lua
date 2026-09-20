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
---@field group_playback_modes group_playback_modes[] Available Source module playback modes.
---@field group_start_conditions group_start_conditions[] Available group start condition types.
---@field group_start_operators group_start_operators[] Operators used to combine group start conditions.
---@field max_num_group_start_criteria integer Maximum number of start conditions per group (4 as of Kontakt 7.5).
---@field max_num_groups integer Maximum number of groups per instrument (4096 as of Kontakt 7.5).
---@field max_num_sample_loops integer Maximum number of sample loops supported (as of Kontakt 7.5 this is 8).
---@field max_num_zones integer Maximum number of zones supported (as of Kontakt 7.5 this is 98304).
---@field sample_loop_modes sample_loop_modes[] Valid loop mode strings. (See sample_loop_modes reference on the Zone page.)
---@field zone_grid_modes zone_grid_modes[] Valid zone grid modes. (See zone_grid_modes reference on the Zone page.)
---@field bus_fx integer Points a preset loading function to the first instrument bus FX chain. Add 1–15 to reach other instrument bus FX chains.
---@field group_fx integer Points a preset loading function to the group FX chain.
---@field insert_fx integer Points a preset loading function to the insert FX chain.
---@field main_fx integer Points a preset loading function to the main FX chain.
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
---| "monolith" Saves a monolith containing the patch and its samples.
---| "patch"    Saves the patch using its current sample references (default).
---| "samples"  Saves the patch and collects its samples separately.
---@alias voice_stealing_modes
---| "any"     Any voice may be stolen.
---| "highest" Prefer the highest voice.
---| "lowest"  Prefer the lowest voice.
---| "newest"  Prefer the newest voice.
---| "oldest"  Prefer the oldest voice.
---@alias group_playback_modes
---| "beat_machine"
---| "dfd"
---| "mpc60_machine"
---| "s1200_machine"
---| "sampler"
---| "time_machine_1"
---| "time_machine_2"
---| "time_machine_pro"
---| "tone_machine"
---| "wavetable"
---@alias group_start_conditions
---| "controller"
---| "key"
---| "random"
---| "round_robin"
---| "slice_trigger"
---@alias group_start_operators
---| "and"     The following condition must also match.
---| "and_not" The following condition must not match.
---| "or"      Either condition may match.
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
---| "any"     Any voice is eligible.
---| "highest" Prefer the highest voice.
---| "lowest"  Prefer the lowest voice.
---| "newest"  Prefer the newest voice.
---| "oldest"  Prefer the oldest voice.

---@class SaveOptions
---@field mode save_modes|nil Save strategy (default: `"patch"`).
---@field absolute_paths boolean|nil Store absolute rather than relative sample paths (default: `false`).
---@field compress_samples boolean|nil Convert collected samples to losslessly compressed NCW files (default: `false`).
---@field samples_sub_dir string|nil Subdirectory used when samples are collected.

---@class Kontakt
Kontakt = {}

-------------------------------------------------------------------------------
-- Multi
-------------------------------------------------------------------------------
--- A multi contains 64 instrument slots. Instrument indices reserve 128 values
--- per slot so that they can also address instruments inside a bank. Prefer
--- indices returned by `Kontakt.get_instrument_indices()` over assuming that
--- loaded instruments are numbered consecutively.

-- Get Property

---@return string Returns the name of the multi.
function Kontakt.get_multi_name() end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return string Returns the title of the multi script in the specified slot.
function Kontakt.get_multi_script_name(multi_script_idx) end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return string Returns the full source of the multi script in the specified slot.
function Kontakt.get_multi_script_source(multi_script_idx) end

---@return integer count Number of loaded instruments; this is a count, not the highest instrument index.
function Kontakt.get_num_instruments() end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return boolean Returns true if the specified multi script slot is bypassed.
function Kontakt.is_multi_script_bypassed(multi_script_idx) end

---@param multi_script_idx integer The zero-based index of the multi script slot.
---@return boolean Returns true if the specified multi script slot is password-protected.
function Kontakt.is_multi_script_protected(multi_script_idx) end

-- Set Property

---Sets the multi name shown by Kontakt.
---@param name string New multi name.
function Kontakt.set_multi_name(name) end

---Changes the bypass state of a multi script slot.
---@param script_idx integer Zero-based multi script slot index (`0` to `Kontakt.max_num_multi_scripts - 1`).
---@param bypass boolean `true` to bypass the script; `false` to enable it.
function Kontakt.set_multi_script_bypassed(script_idx, bypass) end

---Sets the title shown in the multi script slot header.
---@param script_idx integer Zero-based multi script slot index (`0` to `Kontakt.max_num_multi_scripts - 1`).
---@param name string New display name.
function Kontakt.set_multi_script_name(script_idx, name) end

---Loads a multi script into a slot from a Lua file.
---@param script_idx integer Zero-based multi script slot index (`0` to `Kontakt.max_num_multi_scripts - 1`).
---@param source string Absolute path to the Lua source file; this is not inline source text.
function Kontakt.set_multi_script_source(script_idx, source) end

-- Modifiers

---Resets the entire multi to its default empty state, removing all loaded instruments and multi scripts.
function Kontakt.reset_multi() end

-- File I/O

---Saves the current multi using the requested patch/sample handling options.
---@param filename string Absolute destination path for the multi file.
---@param options SaveOptions Save options; omitted fields use their documented defaults.
function Kontakt.save_multi(filename, options) end

---Loads a multi from disk. Kontakt resets the entire instrument rack before loading it.
---@param filename string Absolute path of the multi file to load.
function Kontakt.load_multi(filename) end

-------------------------------------------------------------------------------
-- Instrument
-------------------------------------------------------------------------------

---@class InstrumentOptions
---@field key_switch integer|nil Key switch note, or nil when disabled (default: nil).
---@field key_range_from integer|nil Lowest playable MIDI note (default: 0).
---@field key_range_to integer|nil Highest playable MIDI note (default: 127).
---@field velocity_range_from integer|nil Lowest accepted MIDI velocity (default: 0).
---@field velocity_range_to integer|nil Highest accepted MIDI velocity (default: 127).
---@field midi_transpose integer|nil MIDI input transposition in semitones (default: 0).
---@field wallpaper string|nil Instrument wallpaper path (default: nil).
---@field komplete_ui_module_name string|nil KUI module name without `.kscript`; use dots for nested folders (default: `""`).
---@field komplete_ui_width integer|nil KUI width from 633 to 1000 pixels (default: 633).
---@field komplete_ui_height integer|nil KUI height from 50 to 750 pixels (default: 50).
---@field voice_stealing_mode voice_stealing_modes|nil Voice stealing strategy (default: `"oldest"`).
---@field voice_stealing_fadeout integer|nil Voice-stealing fade-out time in milliseconds (default: 10).
---@field time_machine_voice_limit integer|nil Time Machine voice limit (default: 8).
---@field time_machine_voice_limit_hq integer|nil High-quality Time Machine voice limit (default: 4).
---@field time_machine_use_legacy boolean|nil Use the legacy Time Machine implementation (default: false).
---@field dfd_buffersize integer|nil DFD buffer size (default: 60).
---@field background_loading boolean|nil Enable background sample loading (default: true).
---@field cc_64_mode cc64_modes|nil Sustain-pedal handling mode (default: `"pedal_and_cc"`).
---@field use_cc_120_123 boolean|nil Respond to All Sound Off/All Notes Off controllers (default: true).
---@field use_cc_7_10 boolean|nil Respond to MIDI volume and pan controllers (default: true).
---@field cc_7_range integer|nil MIDI volume controller range (default: 0).
---@field show_factory_snapshots boolean|nil Include factory snapshots in the snapshot browser (default: true).
---@field factory_snapshot_path string|nil Factory snapshot directory; the default depends on the instrument.
---@field user_snapshot_path string|nil User snapshot directory; the default depends on the instrument.
---@field info_icon integer|nil Instrument info icon index (default: 28).
---@field info string|nil Instrument information text (default: `"(null)"`).
---@field info_author string|nil Instrument author shown in the info pane (default: `"Kontakt"`).
---@field info_url string|nil Instrument URL shown in the info pane (default: `"(null)"`).

---@class VoiceGroupOptions
---@field mode voice_group_modes|nil Voice selection mode (default: `"oldest"`).
---@field name string|nil Voice group name (default: `""`).
---@field voices integer|nil Maximum simultaneous voices for this voice group (default: 1).
---@field fade_time integer|nil Voice fade time in milliseconds (default: 10).
---@field prefer_released boolean|nil Prefer voices whose notes have already been released (default: true).
---@field exclusive_group integer|nil Exclusive group assignment (default: nil).

-- Get Property

---Returns the next unoccupied instrument index, or nil when no slot is available.
---@return integer? instrument_idx
function Kontakt.get_free_instrument_index() end

---@param instrument_idx integer Instrument index, preferably obtained from `get_instrument_indices()`.
---@param aux_index integer Zero-based AUX send index.
---@return number level_db AUX send level in dB.
function Kontakt.get_instrument_aux_level(instrument_idx, aux_index) end

---Returns every loaded instrument index. Use these values for APIs accepting `instrument_idx`; indices are not necessarily consecutive when banks are present.
---@return integer[] instrument_indices
function Kontakt.get_instrument_indices() end

---@param instrument_idx integer Instrument index.
---@return integer channel MIDI input channel: `0` is Omni; `1` to `64` address channels 1–16 on ports A–D.
function Kontakt.get_instrument_midi_channel(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return boolean -- True if the instrument is muted.
function Kontakt.get_instrument_mute(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return string -- Returns the name of the instrument.
function Kontakt.get_instrument_name(instrument_idx) end

---Returns all configurable instrument options, including MIDI ranges, voice handling, DFD, snapshots, metadata, and KUI settings.
---@param instrument_idx integer Instrument index.
---@return InstrumentOptions options
function Kontakt.get_instrument_options(instrument_idx) end

---@param instrument_idx integer Instrument index.
---@return integer channel Zero-based audio output channel index.
function Kontakt.get_instrument_output_channel(instrument_idx) end

---@param instrument_idx integer Instrument index.
---@return number percent Output panorama from `-100.0` (left) to `100.0` (right).
function Kontakt.get_instrument_pan(instrument_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@return integer -- Returns the instrument’s polyphony (voice limit).
function Kontakt.get_instrument_polyphony(instrument_idx) end

---@param instrument_idx integer Instrument index.
---@param script_idx integer Zero-based script slot index.
---@return string filename Filename of the script linked from the instrument's resource container; empty when none is linked.
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

---Returns up to 128 voice-group definitions. Each array position corresponds to that voice group index.
---@param instrument_idx integer Instrument index.
---@return VoiceGroupOptions[] voice_groups
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

---Resets the specified instrument to its default state.
---@param instrument_idx integer Instrument index.
function Kontakt.reset_instrument(instrument_idx) end

---Sets an instrument AUX send level.
---@param instrument_idx integer Instrument index.
---@param aux_index integer Zero-based AUX send index (`0` to `Kontakt.max_num_instrument_aux - 1`).
---@param level number Level in dB, from `-math.huge` (off) to `12.0`.
function Kontakt.set_instrument_aux_level(instrument_idx, aux_index, level) end

---Sets the instrument's MIDI input channel.
---@param instrument_idx integer Instrument index.
---@param channel integer `0` for Omni, or `1` to `64` for channels 1–16 on ports A–D.
function Kontakt.set_instrument_midi_channel(instrument_idx, channel) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param mute boolean -- Mutes/unmutes instrument.
function Kontakt.set_instrument_mute(instrument_idx, mute) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param name string -- Sets instrument name.
function Kontakt.set_instrument_name(instrument_idx, name) end

---Updates instrument options. Fields omitted from `options` use the API defaults documented by `InstrumentOptions`.
---@param instrument_idx integer Instrument index.
---@param options InstrumentOptions Options to apply.
function Kontakt.set_instrument_options(instrument_idx, options) end

---Routes the instrument to an audio output. Check the configured output count before assigning an index.
---@param instrument_idx integer Instrument index.
---@param channel integer Zero-based audio output channel index.
function Kontakt.set_instrument_output_channel(instrument_idx, channel) end

---@param instrument_idx integer Instrument index.
---@param pan number Output panorama from `-100.0` (left) to `100.0` (right).
function Kontakt.set_instrument_pan(instrument_idx, pan) end

---@param instrument_idx integer Instrument index.
---@param voices integer Maximum polyphony; minimum value is `1`.
function Kontakt.set_instrument_polyphony(instrument_idx, voices) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param script_idx integer
---@param bypass boolean -- Bypasses/un-bypasses script slot.
function Kontakt.set_instrument_script_bypassed(instrument_idx, script_idx, bypass) end

---Links a script packed inside the instrument's resource container to a script slot.
---@param instrument_idx integer Instrument index.
---@param script_idx integer Zero-based script slot index.
---@param filename string Filename of the packed script inside the resource container.
function Kontakt.set_instrument_script_linked_filename(instrument_idx, script_idx, filename) end

---Sets the title shown in the script slot header or performance-view tab.
---@param instrument_idx integer Instrument index.
---@param script_idx integer Zero-based script slot index.
---@param name string Script title without a file extension.
function Kontakt.set_instrument_script_name(instrument_idx, script_idx, name) end

---Loads a script into an instrument script slot from a Lua file.
---@param instrument_idx integer Instrument index.
---@param script_idx integer Zero-based script slot index.
---@param source string Absolute path to the Lua source file; this is not inline source text.
function Kontakt.set_instrument_script_source(instrument_idx, script_idx, source) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param solo boolean -- Sets solo state.
function Kontakt.set_instrument_solo(instrument_idx, solo) end

---@param instrument_idx integer Instrument index.
---@param tune number Output tuning in semitones, from `-36.0` to `36.0`.
function Kontakt.set_instrument_tune(instrument_idx, tune) end

---@param instrument_idx integer Instrument index.
---@param volume number Output level in dB, from `-math.huge` (silent) to `12.0`.
function Kontakt.set_instrument_volume(instrument_idx, volume) end

---Replaces the instrument's voice-group definitions (maximum 128 entries). A nil array entry resets that voice group to its defaults.
---@param instrument_idx integer Instrument index.
---@param voice_groups VoiceGroupOptions[] Voice groups indexed by voice group number.
function Kontakt.set_voice_groups(instrument_idx, voice_groups) end

-- Modifiers

---Inserts an empty instrument at the requested index, or at the next free index when omitted.
---@param instrument_idx? integer Instrument index to use.
---@return integer instrument_idx Index of the newly created instrument; pass it to other instrument APIs.
function Kontakt.add_instrument(instrument_idx) end

---Inserts an empty instrument bank at the requested rack slot, or at the next free slot when omitted.
---@param instrument_slot? integer Zero-based rack slot (`0` to `Kontakt.max_num_instruments - 1`), not an instrument index inside a bank.
---@return integer instrument_slot Rack slot containing the new bank.
function Kontakt.add_instrument_bank(instrument_slot) end

--- Removes the instrument at the specified instrument index from the multi.
---@param instrument_idx integer -- Zero-based index of instrument to remove.
function Kontakt.remove_instrument(instrument_idx) end 

---Removes the instrument bank at the specified rack slot from the multi.
---@param instrument_slot integer Zero-based rack slot, not an instrument index inside the bank.
function Kontakt.remove_instrument_bank(instrument_slot) end

-- File I/O (Instrument)

---Loads an instrument at the requested index. If that position is occupied, Kontakt uses the next free one. Unlike most slot-oriented APIs, the index may address a position inside an instrument bank.
---@param filename string Absolute path to the instrument file.
---@param instrument_idx? integer Requested instrument index; omit it to use the next free index.
---@return integer instrument_idx Actual index of the loaded instrument.
function Kontakt.load_instrument(filename, instrument_idx) end

---Loads a snapshot file into the specified instrument.
---@param instrument_idx integer Instrument index.
---@param filename string Absolute path to the snapshot file.
function Kontakt.load_snapshot(instrument_idx, filename) end

---Saves an instrument using the requested patch/sample handling options.
---@param instrument_idx integer Instrument index.
---@param filename string Absolute destination path for the instrument file.
---@param options SaveOptions Save options; omitted fields use their documented defaults.
function Kontakt.save_instrument(instrument_idx, filename, options) end

---Saves the current state of an instrument as a snapshot file.
---@param instrument_idx integer Instrument index.
---@param filename string Absolute destination path for the snapshot.
function Kontakt.save_snapshot(instrument_idx, filename) end

-------------------------------------------------------------------------------
-- Group
-------------------------------------------------------------------------------

---@class GroupStartOption
---@field mode group_start_conditions Condition type.
---@field next group_start_operators|nil Operator joining this condition to the next one (default: `"and"`).
---@field key_min integer|nil Lowest note for `"key"` (default: 24).
---@field key_max integer|nil Highest note for `"key"` (default: 24).
---@field controller integer|nil MIDI controller number for `"controller"` (default: 1).
---@field cc_min integer|nil Lowest controller value for `"controller"` (default: 0).
---@field cc_max integer|nil Highest controller value for `"controller"` (default: 64).
---@field position integer|nil Cycle position for `"round_robin"` (default: 1).
---@field zone integer|nil Zone index for `"slice_trigger"` (default: nil).
---@field slice integer|nil Slice index for `"slice_trigger"` (default: nil).
---@field internal boolean|nil Whether a `"slice_trigger"` is internal (default: false).

---@class GroupLoadOptions
---@field replace_zones boolean|nil Replace the destination group's existing zones (default: false).

-- Get Property

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@return string -- Returns the name of the specified group.
function Kontakt.get_group_name(instrument_idx, group_idx) end

---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@return number percent Amplifier panorama from `-100.0` (left) to `100.0` (right).
function Kontakt.get_group_pan(instrument_idx, group_idx) end

---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@return group_playback_modes mode Playback mode of the group's Source module.
function Kontakt.get_group_playback_mode(instrument_idx, group_idx) end

---Returns up to `Kontakt.max_num_group_start_criteria` conditions in evaluation order.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@return GroupStartOption[] options
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

---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@return integer? voice_group Assigned voice group index, or nil when the group has no assignment.
function Kontakt.get_voice_group(instrument_idx, group_idx) end

-- Set Property

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param name string -- Sets the group’s display name.
function Kontakt.set_group_name(instrument_idx, group_idx, name) end

---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@param pan number Amplifier panorama from `-100.0` (left) to `100.0` (right).
function Kontakt.set_group_pan(instrument_idx, group_idx, pan) end

---Sets the playback mode of the group's Source module.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@param mode group_playback_modes Playback mode.
function Kontakt.set_group_playback_mode(instrument_idx, group_idx, mode) end

---Replaces the group's ordered start conditions. At most `Kontakt.max_num_group_start_criteria` entries are accepted; fields omitted from an entry use the defaults documented by `GroupStartOption`.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@param options GroupStartOption[] Ordered start conditions.
function Kontakt.set_group_start_options(instrument_idx, group_idx, options) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param tune number -- Group tuning in semitones (range -36.0 .. 36.0).
function Kontakt.set_group_tune(instrument_idx, group_idx, tune) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param volume number Group amplifier level in dB, from `-math.huge` (silent) to `12.0`.
function Kontakt.set_group_volume(instrument_idx, group_idx, volume) end

--- Assign a voice group to a group. In order to reset the assignment pass nil.
---@param instrument_idx integer -- Zero-based index of the instrument.
---@param group_idx integer -- Zero-based index of the group.
---@param voice_group integer|nil Voice group index; pass nil to clear the assignment.
function Kontakt.set_voice_group(instrument_idx, group_idx, voice_group) end

-- Modifiers

---Adds an empty group to an instrument.
---@param instrument_idx integer Instrument index.
---@return integer new_group_idx Index of the new group; pass it to APIs accepting `group_idx`.
function Kontakt.add_group(instrument_idx) end

---Removes a group from an instrument.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based index of the group to remove.
---@return boolean success Whether the group was removed.
function Kontakt.remove_group(instrument_idx, group_idx) end

-- File I/O

---Saves a group using the requested patch/sample handling options.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based group index.
---@param filename string Absolute destination path for the group file.
---@param options? SaveOptions Save options; omitted fields use their documented defaults.
function Kontakt.save_group(instrument_idx, group_idx, filename, options) end

---Loads a group file into an existing group.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based destination group index.
---@param filename string Absolute path of the group file.
---@param options? GroupLoadOptions Load behavior; omitted fields use their documented defaults.
function Kontakt.load_group(instrument_idx, group_idx, filename, options) end

-------------------------------------------------------------------------------
-- Zone
-------------------------------------------------------------------------------

---@class ZoneGeometry
---@field root_key integer Root MIDI note (default: 36; range: 0–127).
---@field low_key integer Lowest mapped MIDI note (default: 0; range: 0–`high_key`).
---@field high_key integer Highest mapped MIDI note (default: 127; range: `low_key`–127).
---@field low_key_fade integer Low-key crossfade span (default: 0).
---@field high_key_fade integer High-key crossfade span (default: 0).
---@field low_velocity integer Lowest mapped velocity (default: 1; range: 1–`high_velocity`).
---@field high_velocity integer Highest mapped velocity (default: 127; range: `low_velocity`–127).
---@field low_velocity_fade integer Low-velocity crossfade span (default: 0).
---@field high_velocity_fade integer High-velocity crossfade span (default: 0).

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
---@param loop_idx integer Zero-based loop index (`0` to `Kontakt.max_num_sample_loops - 1`).
---@return integer frames Loop length in sample frames.
function Kontakt.get_sample_loop_length(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer Zero-based loop index (`0` to `Kontakt.max_num_sample_loops - 1`).
---@return sample_loop_modes mode Loop playback mode.
function Kontakt.get_sample_loop_mode(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer Zero-based loop index (`0` to `Kontakt.max_num_sample_loops - 1`).
---@return integer frame Loop start in sample frames.
function Kontakt.get_sample_loop_start(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer -- Loop index.
---@return number -- Returns the loop tuning of the specified zone’s loop in semitones.
function Kontakt.get_sample_loop_tune(instrument_idx, zone_idx, loop_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@param loop_idx integer Zero-based loop index (`0` to `Kontakt.max_num_sample_loops - 1`).
---@return integer frames Loop crossfade length in sample frames.
function Kontakt.get_sample_loop_xfade(instrument_idx, zone_idx, loop_idx) end

---Returns the zone's key and velocity ranges, root key, and crossfade spans.
---@param instrument_idx integer Instrument index.
---@param zone_idx integer Zero-based zone index.
---@return ZoneGeometry geometry
function Kontakt.get_zone_geometry(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return number -- Returns the BPM of the specified zone.
function Kontakt.get_zone_grid_bpm(instrument_idx, zone_idx) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index.
---@return zone_grid_modes mode Grid mode of the specified zone.
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

---Returns the sample-end offset as a non-positive frame count relative to the last sample frame. To obtain the absolute Wave Editor position, add this value to `get_zone_sample_frames()`.
---@param instrument_idx integer Instrument index.
---@param zone_idx integer Zero-based zone index.
---@return integer frame_offset
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
---@param mode sample_loop_modes Loop playback mode.
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

---Applies a complete geometry table to a zone. Each fade must fit within its key/velocity range after subtracting the opposite fade.
---@param instrument_idx integer Instrument index.
---@param zone_idx integer Zero-based zone index.
---@param geometry ZoneGeometry Key range, velocity range, root key, and crossfade spans.
function Kontakt.set_zone_geometry(instrument_idx, zone_idx, geometry) end

---Configures the zone's sample grid.
---@param instrument_idx integer Instrument index.
---@param zone_idx integer Zero-based zone index.
---@param mode zone_grid_modes Grid mode.
---@param bpm number Grid tempo in beats per minute.
function Kontakt.set_zone_grid(instrument_idx, zone_idx, mode, bpm) end

---Moves a zone to another existing group without recreating the zone or copying its properties.
---@param instrument_idx integer Instrument index.
---@param zone_idx integer Zero-based zone index.
---@param group_idx integer Zero-based destination group index.
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
---@param frame integer Non-positive frame offset relative to the sample's last frame; use `absolute_end - get_zone_sample_frames()` to convert a Wave Editor position.
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

---Creates a zone, assigns it to a group, and loads a sample into it.
---@param instrument_idx integer Instrument index.
---@param group_idx integer Zero-based destination group index.
---@param filename string Absolute path to the sample file.
---@return integer zone_idx New zone index; pass it to APIs accepting `zone_idx`.
function Kontakt.add_zone(instrument_idx, group_idx, filename) end

---@param instrument_idx integer -- Zero-based index of the instrument.
---@param zone_idx integer -- Zone index to remove.
function Kontakt.remove_zone(instrument_idx, zone_idx) end

---Replaces the zone's loop points with those stored in the sample metadata, when such metadata exists.
---@param instrument_idx integer Instrument index.
---@param zone_idx integer Zero-based zone index.
function Kontakt.restore_loops_from_sample(instrument_idx, zone_idx) end


-------------------------------------------------------------------------------
-- Presets
-------------------------------------------------------------------------------

---Loads a source preset file (`.NKP`) to the specified group of an instrument.
---@param filename string Absolute path of the Source module preset.
---@param instrument_idx integer Target instrument index.
---@param group_idx integer Zero-based target group index.
---@return integer result_code API result code.
function Kontakt.load_source_preset(filename, instrument_idx, group_idx) end

---Loads an effect preset (`.NKP`) into an instrument or output FX chain.
---@param filename string Absolute path of the effect preset.
---@param instrument_or_output_idx integer Instrument index, or an Output-panel channel from `0` to `127` when `generic` is `Kontakt.output_fx`.
---@param group_idx integer Group index when `generic` is `Kontakt.group_fx`; otherwise pass `-1`.
---@param generic integer FX-chain target constant such as `Kontakt.insert_fx`; add `1` to `15` to `Kontakt.bus_fx` to address another instrument bus.
---@return integer result_code API result code.
function Kontakt.load_fx_preset(filename, instrument_or_output_idx, group_idx, generic) end

---Loads a multi script preset file (`.NKP`) into the specified multi script slot of an instrument.
---@param filename string Absolute path of the multi script preset.
---@param instrument_idx integer Target instrument index.
---@param multi_script_idx integer Zero-based multi script slot index.
---@return integer result_code API result code.
function Kontakt.load_multi_script_preset(filename, instrument_idx, multi_script_idx) end

---Loads a script preset file (`.NKP`) into the specified script slot of an instrument.
---@param filename string Absolute path of the script preset.
---@param instrument_idx integer Target instrument index.
---@param script_idx integer Zero-based instrument script slot index.
---@return integer result_code API result code.
function Kontakt.load_script_preset(filename, instrument_idx, script_idx) end

---Loads a complete FX-chain preset (`.NKP`) into an instrument chain. `Kontakt.output_fx` is not supported by this function.
---@param filename string Absolute path of the FX-chain preset.
---@param instrument_idx integer Target instrument index.
---@param group_idx integer Group index when `generic` is `Kontakt.group_fx`; otherwise pass `-1`.
---@param generic integer FX-chain target constant such as `Kontakt.insert_fx`; add `1` to `15` to `Kontakt.bus_fx` to address another instrument bus.
---@return integer result_code API result code.
function Kontakt.load_fx_chain_preset(filename, instrument_idx, group_idx, generic) end


-------------------------------------------------------------------------------
-- Utility
-------------------------------------------------------------------------------

---@class KontaktFileInfo
---@field file string Instrument filename reported by Kontakt.
---@field format string Kontakt file format.
---@field version string Kontakt version stored in the file.
---@field library string|nil Associated library information, when present.
---@field num_instruments integer Number of instruments contained in the file.
---@field num_groups integer Number of groups contained in the file.
---@field num_zones integer Number of zones contained in the file.

-- Functions

---Calls `test` and expects it to fail. Raises an error itself if `test` completes successfully; intended for Lua API unit tests.
---@param test function Function containing the operation expected to fail.
function Kontakt.assert_fail(test) end

---Creates a resource container for an instrument, or updates an existing one, from the obligatory sibling `Resources` folder. Kontakt appends `.nkr` when the extension is omitted.
---@param instrument_idx integer Instrument index.
---@param filename string Absolute destination path of the resource container.
function Kontakt.create_resource_container(instrument_idx, filename) end

---Links an existing resource container to an instrument without requiring a `Resources` folder. Kontakt appends `.nkr` when the extension is omitted.
---@param instrument_idx integer Instrument index.
---@param filename string Path of the existing resource container.
function Kontakt.link_resource_container(instrument_idx, filename) end

---Reads format, version, library, instrument, group, and zone metadata without loading the instrument into the rack.
---@param filename string Path of the Kontakt instrument file to inspect.
---@return KontaktFileInfo file_info
function Kontakt.get_file_info(filename) end

---Runs a sample-pool purge action for an instrument.
---@param instrument_idx integer Instrument index.
---@param mode instrument_purge_modes Purge action.
function Kontakt.instrument_purge(instrument_idx, mode) end

-- File I/O

---Decodes a losslessly compressed NCW sample to an uncompressed WAV file.
---@param source string Path of the source NCW file.
---@param target string Destination path for the WAV file.
function Kontakt.ncw_decode(source, target) end

---Encodes a WAV or AIFF sample using Kontakt's lossless NCW compression.
---@param source string Path of the source WAV or AIFF file.
---@param target string Destination path for the NCW file.
function Kontakt.ncw_encode(source, target) end
