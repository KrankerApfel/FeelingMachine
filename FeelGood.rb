
# === USER INPUTS ===
change_base_melody = 3432
positivity = 0 # 0-3
energy = 3     #0-3
use_random_seed(change_base_melody)

# === Keys by emotions ===

Happy = [(chord :C, :major), chord(:G, :major),chord(:F, :major),chord(:G, :major)]
LoveSick = [(chord :C, :minor7),chord(:Ab, :major7),chord(:Eb, :major7),chord(:Bb, "7")]
Weeping = [(chord :Db, :minor),(chord :Db, :minor),(chord :Db, :minor),(chord :Db, :minor)]
Grief = [(chord :Db, :major7),chord(:Bb, :minor7),chord(:Gb, :major7),chord(:Ab, "7")]
Victorious = [(chord :D, :major7),chord(:B, :minor7),chord(:G, :major7),chord(:A, "7")]
Ruminating = [(chord :D, :minor7),chord(:Bb, :major),chord(:E, "m7-5"),chord(:F, :major7)]
ExistentialAngst = [chord(:Eb, :minor7),chord(:Gb, :major),chord(:Bb, :minor7),chord(:Ab, :minor)]
Cruel = [(chord :Eb, :major7),chord(:G, :minor7),chord(:G, :minor7),chord(:Bb, "7")]
Boisterous = [chord(:Gb, :minor),chord(:B, "7"),(chord :E, :major7),chord(:B, "7")]
Amorous = [(chord :E, :minor),chord(:A, :minor),chord(:Gb, "m7-5"),chord(:D, "m7-5")]
Furious = [(chord :F, :major),chord(:A, :minor7),chord(:Bb, :major),chord(:D, :minor7)]
Funereal = [(chord :F, :minor7),chord(:Ab, :major7),chord(:C, :minor7),chord(:G, "m7-5")]
Patient = [(chord :B, :minor7),chord(:D, :major7),chord(:A, "7"),chord(:E, :minor7)]
Cheerful = [(chord :Bb, :minor7),(chord :Bb, :minor),(chord :B, :minor),(chord :Bb, :minor7)]
Tender = [(chord :A, :minor7),(chord :A, :minor),(chord :A, :minor),(chord :A, :minor7)]
Pastoral = [(chord :A, :major),(chord :A, :major),(chord :A, :major),(chord :A, :major)]

#=== LOOKUP TABLE ===

emotions = [Funereal          ,Grief      ,Ruminating ,Pastoral,  # energy = 0
            ExistentialAngst  ,Weeping    ,Tender     ,Amorous,   # energy = 1
            Cruel             ,LoveSick   ,Patient    ,Cheerful,  # energy = 2
            Funereal          ,Victorious ,Boisterous ,Happy]     # energy = 3

#=== DO THE AWESOME =====
length = 3
chords = emotions[positivity*length+energy].ring
c = chords[0]
use_bpm 10 + 4*Math.exp(energy) + positivity + change_base_melody%20
# === PLAY ===
live_loop :melody do
  use_synth :blade
  r = [0.25, 0.25, 0.5, 1].choose
  play c.choose, attack: 0, release: r
  sleep r
end

live_loop :keys do
  use_synth :blade
  play c
  sleep 1
end

live_loop :bass do
  use_synth :fm
  use_octave -2
  3.times do
    play c[0] # play the first note of the chord
    sleep 1
  end
  play c[2] # play the third note of the chord
  sleep 0.5
  play c[1] # # play the second note of the chord
  sleep 0.5
  c = chords.tick
end