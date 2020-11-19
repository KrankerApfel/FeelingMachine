
# === USER INPUTS ===
change_base_melody = 8895
positivity =2  # 0-3
energy = 2    #0-3
use_random_seed(change_base_melody)

# === Keys by emotions ===

Happy = [(chord :C, :major), chord(:G, :major),chord(:F, :major),chord(:G, :major)]
LoveSick = [(chord :B4, :minor7),chord(:E5, :minor),chord(:G4, :minor7),chord(:Bb, "7")]
Weeping = [(chord :Db, :minor),(chord :D, "7"),(chord :F, :minor7),(chord :A, :major)]
Grief = [(chord :C7, :minor),chord(:A, :minor),chord(:Eb, :minor),chord(:Gb, :minor)]
Victorious = [chord(:G, :minor),chord(:F, :major),(chord :E, :minor),chord(:A, :major)]
Ruminating = [(chord :D, :minor7),chord(:Bb, :major),chord(:E, "m7-5"),chord(:F, :major7)]
ExistentialAngst = [chord(:Eb, :minor7),chord(:Gb, :major),chord(:Bb, :minor7),chord(:Ab, :minor)]
Cruel = [(chord :Eb, :minor7),chord(:G, :minor7),chord(:G, "m7-5"),chord(:Bb, "7")]
Boisterous = [(chord :D, :major7),chord(:B, :major7),chord(:G, :major7),chord(:A, "7")]
Amorous = [(chord :E, :major),chord(:A, :minor),chord(:Gb, "m7-5"),chord(:D, "m7-5")]
Furious = [(chord :Ab, :minor),chord(:A, :minor),chord(:Bb, :minor),chord(:E, :minor)]
Funereal = [(chord :Ab2, :minor),chord(:C3, :minor),chord(:Eb3, :minor),(chord :Ab2, :minor)]
Patient = [(chord :B, :minor7),chord(:D, :major7),chord(:A, "7"),chord(:E, :minor7)]
Cheerful = [(chord :A4, :major),(chord :F4, :major),(chord :C4, :major),(chord :G4, :major)]
Tender = [(chord :A, :major7),(chord :G, :major),(chord :A, :major7),(chord :Bb, :major)]
Pastoral = [(chord :C, :major),(chord :F, :major),(chord :A, :major7),(chord :G, :major)]

#=== LOOKUP TABLE ===

#--------- positivity = 0     | positivity = 1 | positivity = 2 | positivity = 3

emotions = [Funereal          , Weeping        , Ruminating     , Pastoral,   # energy = 0
            ExistentialAngst  , Grief          , Tender         , Amorous,    # energy = 1
            Cruel             , LoveSick       , Patient        , Cheerful,   # energy = 2
            Furious           , Victorious     , Boisterous     , Happy]      # energy = 3

#=== DO THE AWESOME =====
length = 4
chords = emotions[energy*length+positivity].ring
#chords = Cheerful.ring

c = chords[0]
use_bpm 10 + 4.8*Math.exp(energy) +0.2*positivity + change_base_melody%20

# === PLAY ===
use_transpose change_base_melody % 12

live_loop :melody do
  use_synth :blade
  r = [0.25, 0.25, 0.25, 0.5, 0.5, 0.75, 1].choose
  play c.choose, attack: 0, release: r
  sleep r
end

live_loop :keys do
  use_synth :prophet
  play c
  sleep 1
end

live_loop :bass do
  use_synth :fm
  use_octave -2
  3.times do #verse
    play c[0] # play the first note of the chord
    sleep 1
  end #chorus
  play c.choose
  sleep 0.5
  play c.choose
  sleep 0.5
  c = chords.choose
end