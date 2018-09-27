/* Copyright © 2018 Pascal JEAN, All rights reserved.
 * This file is part of the Piduino Library.
 *
 * The Piduino Library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * The Piduino Library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with the Piduino Library; if not, see <http://www.gnu.org/licenses/>.
 */
#ifndef PIDUINO_ARCH_ARM_ALLWINNER_PWM_HX_H
#define PIDUINO_ARCH_ARM_ALLWINNER_PWM_HX_H

#include <piduino/socpwm.h>
#include <piduino/iomap.h>
#include "hx.h"

namespace Piduino {

  namespace AllWinnerHx {

    /**
     * @class AllWinnerHx::PwmEngine
     * @brief
     */
    class PwmEngine  : public SocPwm::Engine {

      public:
        PwmEngine (SocPwm::Private * d, Pin * p);
        ~PwmEngine();

        bool open (IoDevice::OpenMode mode);
        void close();
        const std::string & deviceName() const;

        // isOpen() checked before calling this functions
        long frequency() const;
        int  resolution() const;
        long max() const;
        long min() const;
        bool setFrequency (long freq);
        bool setResolution (int resolution);

        // hasPin() checked before calling this functions
        long read();
        bool write (long value);
        void setEnable (bool enable);
        bool isEnabled () const;

      private:
        IoMap pwm;
        size_t dataReg;
        uint32_t ctlMasqInit;
        uint32_t ctlMasqStartStop;

        uint32_t clockDivisor() const;
        void setClockDivisor (uint32_t div);
        uint32_t frequencyDivisor (long freq);
        uint16_t range() const;
        void setRange(uint16_t r);

        inline uint32_t readPwm (size_t offset) const {
          return *pwm.io (offset);
        }
        inline void writePwm (size_t offset, uint32_t value) {
          *pwm.io (offset) = value;
        }
    };
  }
}

/* ========================================================================== */
#endif /* PIDUINO_ARCH_ARM_ALLWINNER_PWM_HX_H defined */
