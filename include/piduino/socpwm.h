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

#ifndef PIDUINO_SOCPWM_H
#define PIDUINO_SOCPWM_H

#include <piduino/pwm.h>
#include <piduino/gpiopin.h>

/**
 *  @defgroup piduino_gpiopwm GPIO PWM generator
 *  @{
 */

namespace Piduino {

  class SocPwm : public Pwm {

    public:
      SocPwm (Pin * pin);
      virtual ~SocPwm();
      
      // Converter
      virtual const std::string & deviceName() const;
      
      // Pwm
      virtual long frequency() const;
      virtual bool setFrequency (long freq);
      
      // SocPwm
      const Pin * pin() const;
      bool isNull() const;
      bool isPwmPin (const Pin * pin) const;

    protected:
      class Private;
      SocPwm (Private &dd);

    private:
      PIMP_DECLARE_PRIVATE (SocPwm)
  };
}
/**
 *  @}
 */

/* ========================================================================== */
#endif /*PIDUINO_SOCPWM_H defined */
