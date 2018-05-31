-- Creator:       MySQL Workbench 6.3.6/ExportSQLite Plugin 0.1.0
-- Author:        epsilonrt
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2018-05-04 14:58
-- Created:       2018-04-23 13:23
PRAGMA foreign_keys = OFF;

-- Schema: piduino
ATTACH "piduino.db" AS "piduino";
BEGIN;
CREATE TABLE "piduino"."gpio_connector_family"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  "columns" INTEGER NOT NULL,
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."gpio_pin_name"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."board_family"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."gpio_pin_type"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."gpio_pin_mode"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."gpio"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."gpio_connector"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  "rows" INTEGER,
  "gpio_connector_family_id" INTEGER NOT NULL,
  CONSTRAINT "fk_gpio_connector_gpio_connector_family"
    FOREIGN KEY("gpio_connector_family_id")
    REFERENCES "gpio_connector_family"("id")
);
CREATE TABLE "piduino"."arch"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."manufacturer"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name")
);
CREATE TABLE "piduino"."gpio_pin"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "gpio_pin_type_id" INTEGER NOT NULL,
  "logical_num" INTEGER NOT NULL,
  "mcu_num" INTEGER NOT NULL,
  "system_num" INTEGER NOT NULL,
  CONSTRAINT "fk_gpio_pin_gpio_pin_type1"
    FOREIGN KEY("gpio_pin_type_id")
    REFERENCES "gpio_pin_type"("id")
);
CREATE TABLE "piduino"."gpio_has_connector"(
  "num" INTEGER NOT NULL,
  "gpio_id" INTEGER NOT NULL,
  "gpio_connector_id" INTEGER NOT NULL,
  CONSTRAINT "fk_gpio_has_connector_gpio1"
    FOREIGN KEY("gpio_id")
    REFERENCES "gpio"("id"),
  CONSTRAINT "fk_gpio_has_connector_gpio_connector1"
    FOREIGN KEY("gpio_connector_id")
    REFERENCES "gpio_connector"("id")
);
CREATE TABLE "piduino"."soc_family"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  "arch_id" INTEGER NOT NULL,
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name"),
  CONSTRAINT "fk_soc_family_arch1"
    FOREIGN KEY("arch_id")
    REFERENCES "arch"("id")
);
CREATE TABLE "piduino"."gpio_connector_has_pin"(
  "gpio_connector_id" INTEGER NOT NULL,
  "gpio_pin_id" INTEGER NOT NULL,
  "row" INTEGER NOT NULL,
  "column" INTEGER NOT NULL,
  CONSTRAINT "fk_gpio_connector_has_pin_gpio_connector1"
    FOREIGN KEY("gpio_connector_id")
    REFERENCES "gpio_connector"("id"),
  CONSTRAINT "fk_gpio_connector_has_pin_gpio_pin1"
    FOREIGN KEY("gpio_pin_id")
    REFERENCES "gpio_pin"("id")
);
CREATE TABLE "piduino"."soc"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  "soc_family_id" INTEGER NOT NULL,
  "manufacturer_id" INTEGER NOT NULL,
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name"),
  CONSTRAINT "fk_soc_soc_family1"
    FOREIGN KEY("soc_family_id")
    REFERENCES "soc_family"("id"),
  CONSTRAINT "fk_soc_manufacturer1"
    FOREIGN KEY("manufacturer_id")
    REFERENCES "manufacturer"("id")
);
CREATE TABLE "piduino"."gpio_pin_has_name"(
  "gpio_pin_id" INTEGER NOT NULL,
  "gpio_pin_name_id" INTEGER NOT NULL,
  "gpio_pin_mode_id" INTEGER NOT NULL,
  CONSTRAINT "fk_gpio_pin_has_name_gpio_pin1"
    FOREIGN KEY("gpio_pin_id")
    REFERENCES "gpio_pin"("id"),
  CONSTRAINT "fk_gpio_pin_has_name_gpio_pin_name1"
    FOREIGN KEY("gpio_pin_name_id")
    REFERENCES "gpio_pin_name"("id"),
  CONSTRAINT "fk_gpio_pin_has_name_gpio_pin_mode1"
    FOREIGN KEY("gpio_pin_mode_id")
    REFERENCES "gpio_pin_mode"("id")
);
CREATE TABLE "piduino"."board"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "tag" VARCHAR(45),
  "revision" INTEGER CHECK("revision">=0),
  "ram" INTEGER DEFAULT 0,
  "pcb_revision" DECIMAL,
  "board_model_id" INTEGER NOT NULL,
  "gpio_id" INTEGER NOT NULL,
  "manufacturer_id" INTEGER NOT NULL,
  CONSTRAINT "revision_UNIQUE"
    UNIQUE("revision"),
  CONSTRAINT "tag_UNIQUE"
    UNIQUE("tag"),
  CONSTRAINT "fk_board_board_model1"
    FOREIGN KEY("board_model_id")
    REFERENCES "board_model"("id"),
  CONSTRAINT "fk_board_gpio1"
    FOREIGN KEY("gpio_id")
    REFERENCES "gpio"("id"),
  CONSTRAINT "fk_board_manufacturer1"
    FOREIGN KEY("manufacturer_id")
    REFERENCES "manufacturer"("id")
);
CREATE TABLE "piduino"."board_model"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  "board_family_id" INTEGER NOT NULL,
  "soc_id" INTEGER NOT NULL,
  CONSTRAINT "name_UNIQUE"
    UNIQUE("name"),
  CONSTRAINT "fk_board_model_board_family1"
    FOREIGN KEY("board_family_id")
    REFERENCES "board_family"("id"),
  CONSTRAINT "fk_board_model_soc1"
    FOREIGN KEY("soc_id")
    REFERENCES "soc"("id")
);
COMMIT;