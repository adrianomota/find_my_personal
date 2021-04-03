defmodule FindMyPersonal.Teachers.Teacher do
  @moduledoc """
  Teacher module
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "teacher" do
    field :avatar_url, :string
    field :birth_date, :date
    field :class_typel, :string
    field :education_level, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:avatar_url, :name, :birth_date, :education_level, :class_typel])
    |> validate_required([:avatar_url, :name, :birth_date, :education_level, :class_typel])
  end
end
