#pragma once
#include <string>
#include "PitchClass.h"

namespace libmus {
	class Pitch
	{
	private:
		PitchClass pitchClass;
		int octave;
	public:
		Pitch();
		static Pitch Parse(std::string pitch);
		static Pitch Random();
		static Pitch ExtendedRandom();

		__declspec(property(get = GetStep, put = SetStep)) int Step;
		int GetStep();
		void SetStep(int value);

		__declspec(property(get = GetAlteration, put = SetAlteration)) int Alteration;
		int GetAlteration();
		void SetAlteration(int value);

		__declspec(property(get = GetOctave, put = SetOctave)) int Octave;
		int GetOctave();
		void SetOctave(int value);

		std::string Name();
		std::string PrettyName();
		std::string FullName();

		const int MIN_STEP = PitchClass::MIN_STEP;
		const int MAX_STEP = PitchClass::MAX_STEP;
		const int MIN_ALTERATION = PitchClass::MIN_ALTERATION;
		const int MAX_ALTERATION = PitchClass::MAX_ALTERATION;
		const int MIN_OCTAVE = 0;
		const int MAX_OCTAVE = 10;
	};
}