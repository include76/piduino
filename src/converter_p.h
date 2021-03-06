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

#ifndef PIDUINO_CONVERTER_PRIVATE_H
#define PIDUINO_CONVERTER_PRIVATE_H

#include <piduino/converter.h>
#include "iodevice_p.h"

namespace Piduino {

  /**
   * @class Converter::Private
   * @brief
   */
  class Converter::Private  : public IoDevice::Private {

    public:
      Private (Converter * q, Type type = None, unsigned int resolution = 8, bool bipolar = false);
      virtual ~Private();

      virtual bool open (OpenMode mode);
      virtual void close();
      virtual long read();
      virtual bool write (long value);
      virtual long max() const;
      virtual long min() const;

      Type type;
      bool bipolar;
      unsigned int resolution;

      PIMP_DECLARE_PUBLIC (Converter)
  };
}

/* ========================================================================== */
#endif /* PIDUINO_CONVERTER_PRIVATE_H defined */
