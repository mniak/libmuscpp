package libmus

import (
	"errors"
	"fmt"
	"strconv"
)

const (
	MIN_OCTAVE = 0
	MAX_OCTAVE = 10
)

var (
	ErrInvalidPitch       = errors.New("invalid pitch")
	ErrInvalidPitchOctave = errors.New("invalid pitch octave")
)

var octaves []int

func init() {
	for i := MIN_OCTAVE; i <= MAX_OCTAVE; i++ {
		octaves = append(octaves, i)
	}
}

type Pitch struct {
	PitchClass
	Octave int
}

func ParsePitch(text string) (Pitch, error) {
	var pitch Pitch
	var err error

	if len(text) == 0 {
		return pitch, ErrInvalidPitch
	}

	lastDigit := text[len(text)-1:]
	pitch.Octave, err = strconv.Atoi(lastDigit)
	if err != nil || pitch.Octave == 0 {
		return pitch, ErrInvalidPitchOctave
	}

	pitchClassString := text[:len(text)-2]
	pitch.PitchClass, err = ParsePitchClass(pitchClassString)
	if err != nil {
		return pitch, err
	}
	return pitch, nil
}

func RandomPitch() Pitch {
	pitch := Pitch{}
	pitch.PitchClass = RandomPitchClass()
	pitch.Octave = pickRandom(octaves)
	return pitch
}

func ExtendedRandomPitch() Pitch {
	pitch := Pitch{}
	pitch.PitchClass = ExtendedRandomPitchClass()
	pitch.Octave = pickRandom(octaves)
	return pitch
}

func (p Pitch) String() string {
	return p.Name()
}

func (p *Pitch) GetStep() Step {
	return p.PitchClass.GetStep()
}

func (p *Pitch) SetStep(value Step) {
	p.PitchClass.SetStep(value)
}

func (p *Pitch) GetAlteration() Alteration {
	return p.PitchClass.GetAlteration()
}

func (p *Pitch) SetAlteration(value Alteration) {
	p.PitchClass.SetAlteration(value)
}

func (p *Pitch) GetOctave() int {
	return p.Octave
}

func (p *Pitch) SetOctave(value int) {
	p.Octave = trunc(value, MIN_OCTAVE, MAX_OCTAVE)
}

func (p *Pitch) Name() string {
	octaveString := fmt.Sprint(p.Octave)
	return p.PitchClass.Name() + octaveString
}

func (p *Pitch) PrettyName() string {
	oct := SUPERSCRIPT_OCTAVES[p.Octave]
	return p.PitchClass.PrettyName() + oct
}

func (p *Pitch) FullName() string {
	octaveString := fmt.Sprint(p.Octave)
	return p.PitchClass.FullName() + " " + octaveString
}

func (p *Pitch) MIDINote() int {
	note := p.PitchClass.number() + 12*(p.Octave+1)
	return note
}

func (p *Pitch) Class() PitchClass {
	return p.PitchClass
}

func (p Pitch) normalized() Pitch {
	p.PitchClass = p.PitchClass.normalized()
	// if p.Octave == 0 {
	// 	p.Octave = 4
	// } else {
	p.Octave = trunc(p.Octave, 1, 9)
	// }
	return p
}

func (p Pitch) Transpose(i Interval) Pitch {
	numBefore := p.MIDINote()
	p.step += Step(i.Degree - 1)
	if i.Degree < 0 {
		p.step += 2
	}
	numberDiff := p.MIDINote() - numBefore
	p.alteration = Alteration(i.Semitones() - numberDiff)
	return p.normalized()
}
