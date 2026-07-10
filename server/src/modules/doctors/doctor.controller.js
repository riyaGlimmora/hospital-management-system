const doctorService = require('./doctor.service');

async function createDoctor(req, res, next) {
  try {
    const doctor = await doctorService.createDoctor(req.body);
    res.status(201).json({
      success: true,
      message: 'Doctor created successfully',
      data: doctor,
    });
  } catch (error) {
    next(error);
  }
}

async function getDoctor(req, res, next) {
  try {
    const { id } = req.params;
    const includeInactive = req.query.includeInactive === 'true';
    const doctor = await doctorService.getDoctor(id, { includeInactive });
    res.status(200).json({
      success: true,
      message: 'Doctor retrieved successfully',
      data: doctor,
    });
  } catch (error) {
    next(error);
  }
}

async function updateDoctor(req, res, next) {
  try {
    const { id } = req.params;
    const doctor = await doctorService.updateDoctor(id, req.body);
    res.status(200).json({
      success: true,
      message: 'Doctor updated successfully',
      data: doctor,
    });
  } catch (error) {
    next(error);
  }
}

async function deleteDoctor(req, res, next) {
  try {
    const { id } = req.params;
    const doctor = await doctorService.deleteDoctor(id);
    res.status(200).json({
      success: true,
      message: 'Doctor deleted successfully',
      data: doctor,
    });
  } catch (error) {
    next(error);
  }
}

async function listDoctors(req, res, next) {
  try {
    const pageNumber = Number(req.query.page) || 1;
    const limitNumber = Number(req.query.limit) || 10;
    const includeInactive = req.query.includeInactive === 'true';
    const departmentId = req.query.departmentId ? Number(req.query.departmentId) : undefined;
    const result = await doctorService.listDoctors({
      page: pageNumber,
      limit: limitNumber,
      includeInactive,
      departmentId,
    });
    res.status(200).json({
      success: true,
      message: 'Doctors retrieved successfully',
      data: result,
    });
  } catch (error) {
    next(error);
  }
}

async function searchDoctors(req, res, next) {
  try {
    const pageNumber = Number(req.query.page) || 1;
    const limitNumber = Number(req.query.limit) || 10;
    const includeInactive = req.query.includeInactive === 'true';
    const departmentId = req.query.departmentId ? Number(req.query.departmentId) : undefined;
    const result = await doctorService.searchDoctors({
      searchTerm: req.query.search,
      page: pageNumber,
      limit: limitNumber,
      includeInactive,
      departmentId,
    });
    res.status(200).json({
      success: true,
      message: 'Doctor search results retrieved successfully',
      data: result,
    });
  } catch (error) {
    next(error);
  }
}

module.exports = {
  createDoctor,
  getDoctor,
  updateDoctor,
  deleteDoctor,
  listDoctors,
  searchDoctors,
};