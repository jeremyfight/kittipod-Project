--Populate Property Address data clean null and update data
Select a.ParcelID, a.PropertyAddress, b.ParcelID, 
	   b.PropertyAddress, 
	   ifNULL(a.PropertyAddress,b.PropertyAddress)
From Nashville a
JOIN Nashville b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From Nashville a
JOIN Nashville b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--Breaking out Address into Individual Columns (Address, City, State)
Select PropertyAddress
From Nashville

SELECT
substr(PropertyAddress, 1, instr(PropertyAddress, ',') -1),
From Nashville

-- Change Y and N to Yes and No in "Sold as Vacant" field
Select Distinct(SoldAsVacant), 	   
	   Count(SoldAsVacant)
From Nashville
Group by SoldAsVacant
order by 2

Select SoldAsVacant,
	 CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From Nashville

--uddate SoldAsVacant
Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

-- Remove Duplicates
WITH DuplicatesETC AS(
Select  *,
	row_number() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference)
				 Duplicates

From Nashville
)

Select *
from DuplicatesETC
WHERE Duplicates > 1

--
