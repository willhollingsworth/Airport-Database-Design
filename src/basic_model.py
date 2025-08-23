from sqlmodel import Field, Relationship, SQLModel

# MARK: Airline and Country


class Country(SQLModel, table=True):
    id: int = Field(primary_key=True)
    airlines: list["Airline"] = Relationship(back_populates="country")


class Airline(SQLModel, table=True):
    id: str = Field(primary_key=True)
    country_id: int = Field(foreign_key="country.id")

    country: Country = Relationship(back_populates="airlines")
    aircraft_ownerships: list["AircraftOwnership"] = Relationship(
        back_populates="airline",
    )


# MARK: Aircrafts


class AircraftOwnership(SQLModel, table=True):
    """Association table for aircraft ownership history."""

    aircraft_id: int = Field(foreign_key="aircraft.id", primary_key=True)
    airline_id: str = Field(foreign_key="airline.id", primary_key=True)

    aircraft: "Aircraft" = Relationship(back_populates="ownership_history")
    airline: "Airline" = Relationship(back_populates="aircraft_ownerships")


class Aircraft(SQLModel, table=True):
    id: int = Field(primary_key=True)  # 6-digit serial number

    ownership_history: list["AircraftOwnership"] = Relationship(
        back_populates="aircraft",
    )
    sub_model_id: str = Field(default=None, foreign_key="aircraftsubmodel.id")
    sub_model: "AircraftSubModel" = Relationship(back_populates="aircraft")


class Manufacturer(SQLModel, table=True):
    id: int = Field(primary_key=True)

    models: list["AircraftModel"] = Relationship(back_populates="manufacturer")


class AircraftModel(SQLModel, table=True):
    id: str = Field(primary_key=True)
    manufacturer_id: int = Field(foreign_key="manufacturer.id")
    manufacturer: Manufacturer = Relationship(back_populates="models")
    sub_models: list["AircraftSubModel"] = Relationship(back_populates="model")


class AircraftSubModel(SQLModel, table=True):
    id: str = Field(primary_key=True)
    model_id: str = Field(foreign_key="aircraftmodel.id")
    engine_model_name: str = Field(foreign_key="enginemodel.name")

    model: AircraftModel = Relationship(back_populates="sub_models")
    aircraft: list["Aircraft"] = Relationship(back_populates="sub_model")


class EngineModel(SQLModel, table=True):
    name: str = Field(primary_key=True)

    sub_models: list["AircraftSubModel"] = Relationship(
        back_populates="engine_model",
    )
    engines: list["Engine"] = Relationship(back_populates="engine_model")


class Engine(SQLModel, table=True):
    id: str = Field(primary_key=True)  # Engine identification number
    engine_model_name: str = Field(foreign_key="enginemodel.name")
    aircraft_id: int | None = Field(foreign_key="aircraft.id")

    engine_model: EngineModel = Relationship(back_populates="engines")
    aircraft: Aircraft | None = Relationship(back_populates="engines")
