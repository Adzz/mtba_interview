defmodule Mtba do
  @moduledoc """
  """
  require Logger

  @products_path "./products.txt"
  @sales_path "./sales.txt"

  @doc """
  """
  def ingest_products() do
    @products_path
    |> Path.expand()
    |> File.stream!()
    |> CSV.decode!(separator: ?\t, headers: false)
    |> Enum.reduce([], fn
      [""], acc -> acc
      [product_name], acc -> [%{name: product_name, category: nil} | acc]
      [product_name, category], acc -> [%{name: product_name, category: category} | acc]
    end)
  end

  def ingest_sales() do
    @sales_path
    |> Path.expand()
    |> File.stream!()
    |> CSV.decode!(separator: ?\t, headers: false)
    |> Enum.reduce([], fn
      [""], acc -> acc
      [product_name, price], acc -> [%{name: product_name, price: Decimal.new(price)} | acc]
    end)
  end

  @doc """
  Returns a tuple of the total number of sales made and the total price of all those sales
  """
  def individual_sales() do
    sales_data = ingest_sales()

    total =
      Enum.reduce(sales_data, Decimal.new("0"), fn row, total ->
        Decimal.add(total, row.price)
      end)
      |> Decimal.round(2)

    {length(sales_data), total}
  end

  @doc """
  Returns the top 5 selling categories by revenue.
  """
  def top_five_categories_by_revenue() do
    sales_data = ingest_sales()
    products = ingest_products()

    categories = product_to_categories(products)

    Enum.reduce(sales_data, %{}, fn sale, grouped ->
      category = Map.get(categories, sale.name)

      if category |> is_nil do
        Logger.error("Incorrect product name found: #{sale.name}")
        grouped
      else
        case Map.get(grouped, category) do
          nil ->
            Map.put(grouped, category, {1, Decimal.round(sale.price, 2)})

          {count, product_total} ->
            Map.put(grouped, category, {count + 1, Decimal.add(sale.price, product_total)})
        end
      end
    end)
    |> Enum.map(& &1)
    |> Enum.sort_by(fn {_name, {_count, revenue}} -> revenue end, {:desc, Decimal})
    |> Enum.take(5)
  end

  def top_selling_candy() do
  end

  # We want a mapping from products to categories so we know which total
  # to include it within.
  defp product_to_categories(products) do
    Enum.reduce(products, %{}, fn
      product, categories -> Map.put(categories, product.name, product.category)
    end)
  end
end
