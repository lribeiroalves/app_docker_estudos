from . import db

from sqlalchemy import String, Integer, DateTime, Boolean, ForeignKey, Column, CheckConstraint, BigInteger, Text, LargeBinary, Float
from sqlalchemy.orm import Mapped, mapped_column, relationship
from typing import Optional
from datetime import datetime


class Users(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True)
    nome: Mapped[str] = mapped_column(String(255), nullable=False)
    idade: Mapped[int] = mapped_column(Integer, nullable=False)
